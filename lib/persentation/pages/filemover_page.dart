import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/domain/entity/file_mover_history.dart';
import 'package:wavenadmin/domain/usecase/save_file_mover_history.dart';
import 'package:wavenadmin/domain/usecase/get_file_mover_histories.dart';
import 'package:wavenadmin/domain/usecase/clear_file_mover_history.dart';
import 'package:wavenadmin/injection.dart';
import 'package:intl/intl.dart';

class Pengaturan extends StatelessWidget {
  const Pengaturan({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: FileMoverPage());
  }
}

class FileMoverPage extends StatefulWidget {
  const FileMoverPage({super.key});

  @override
  State<FileMoverPage> createState() => _FileMoverPageState();
}

class _FileMoverPageState extends State<FileMoverPage> {
  final TextEditingController _fileNamesController = TextEditingController();
  String _selectedExtension = '.jpg';
  final List<String> _availableExtensions = ['.jpg', '.JPG', '.ARW'];

  List<FileMoverHistory> _histories = [];
  String _statusLog = "Siap.";
  bool _isProcessing = false;
  bool _isLoadingHistory = false;
  final bool _isAndroid = Platform.isAndroid;

  @override
  void initState() {
    super.initState();
    _loadHistories();
  }

  @override
  void dispose() {
    _fileNamesController.dispose();
    super.dispose();
  }

  Future<bool> _requestStoragePermission() async {
    if (!_isAndroid) return true; // Desktop tidak perlu permission

    final status = await Permission.storage.request();
    
    if (status.isDenied) {
      _updateStatus('❌ Storage permission ditolak');
      return false;
    } else if (status.isPermanentlyDenied) {
      _updateStatus('❌ Storage permission tidak bisa diakses. Buka Settings.');
      openAppSettings();
      return false;
    }
    
    return true;
  }

  Future<void> _loadHistories() async {
    setState(() => _isLoadingHistory = true);
    try {
      final histories = await locator<GetFileMoverHistories>().execute();
      setState(() {
        _histories = histories;
        _isLoadingHistory = false;
      });
    } catch (e) {
      setState(() => _isLoadingHistory = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal memuat history: $e')));
      }
    }
  }

  Future<void> _clearHistory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua History'),
        content: const Text('Apakah Anda yakin ingin menghapus semua history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await locator<ClearFileMoverHistory>().execute();
        await _loadHistories();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('History berhasil dihapus')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus history: $e')),
          );
        }
      }
    }
  }

  List<String> _parseFileNames() {
    final input = _fileNamesController.text.trim();
    if (input.isEmpty) return [];

    return input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .map(
          (e) => e.endsWith(_selectedExtension) ? e : '$e$_selectedExtension',
        )
        .toList();
  }

  Future<void> findAndMoveFiles() async {
    final filesFromApi = _parseFileNames();

    if (filesFromApi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon masukkan nama file terlebih dahulu'),
        ),
      );
      return;
    }

    // Request permission untuk Android
    if (!await _requestStoragePermission()) {
      return;
    }

    setState(() {
      _isProcessing = true;
      _statusLog = "Menunggu pemilihan folder...";
    });

    try {
      // 1. Pilih Folder SUMBER
      String? sourcePath;
      
      if (_isAndroid) {
        sourcePath = await FilePicker.platform.getDirectoryPath(
          dialogTitle: "Pilih Folder SUMBER dari Documents/Download",
          lockParentWindow: true,
        );
      } else {
        sourcePath = await FilePicker.platform.getDirectoryPath(
          dialogTitle: "Pilih Folder SUMBER (Asal File)",
          lockParentWindow: true,
        );
      }

      if (sourcePath == null) {
        _updateStatus("Batal memilih folder sumber.");
        return;
      }

      // Preview file yang ada di folder sumber
      final sourceDir = Directory(sourcePath);
      List<FileSystemEntity> entities = [];
      try {
        entities = sourceDir.listSync();
      } catch (e) {
        _updateStatus("Error: Tidak bisa membaca folder sumber ($e)");
        setState(() => _isProcessing = false);
        return;
      }

      // Filter hanya file dengan ekstensi yang dipilih
      final filesInSource = entities
          .whereType<File>()
          .where((file) => p.basename(file.path).endsWith(_selectedExtension))
          .map((file) => p.basename(file.path))
          .toList();

      // Cek file mana yang akan dipindahkan
      final foundFiles = filesFromApi
          .where((targetFile) => filesInSource.contains(targetFile))
          .toList();

      final notFoundFiles = filesFromApi
          .where((targetFile) => !filesInSource.contains(targetFile))
          .toList();

      // Tampilkan preview dialog
      final confirmed = await _showPreviewDialog(
        sourcePath,
        filesInSource,
        foundFiles,
        notFoundFiles,
      );

      if (confirmed != true) {
        _updateStatus("Batal memproses.");
        return;
      }

      // 2. Pilih Folder TUJUAN
      String? destPath;
      
      if (_isAndroid) {
        destPath = await FilePicker.platform.getDirectoryPath(
          dialogTitle: "Pilih Folder TUJUAN di Documents/Download",
          lockParentWindow: true,
        );
      } else {
        destPath = await FilePicker.platform.getDirectoryPath(
          dialogTitle: "Pilih Folder TUJUAN (Tempat Simpan)",
          lockParentWindow: true,
        );
      }

      if (destPath == null) {
        _updateStatus("Batal memilih folder tujuan.");
        return;
      }

      // Mulai Proses Pemindahan
      await _processMoving(sourcePath, destPath, filesFromApi);
    } catch (e) {
      _updateStatus("Terjadi kesalahan sistem: $e");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<bool?> _showPreviewDialog(
    String sourcePath,
    List<String> allFiles,
    List<String> foundFiles,
    List<String> notFoundFiles,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Preview File di Folder Sumber"),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Folder: $sourcePath",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),

                if (foundFiles.isNotEmpty) ...[
                  const Text(
                    "✅ File yang akan dipindahkan:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...foundFiles.map(
                    (file) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              file,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                if (notFoundFiles.isNotEmpty) ...[
                  const Text(
                    "⚠️ File tidak ditemukan:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...notFoundFiles.map(
                    (file) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning,
                            size: 16,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              file,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                ExpansionTile(
                  title: Text(
                    "Semua file ${_selectedExtension} di folder (${allFiles.length})",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: allFiles.length,
                        itemBuilder: (context, index) {
                          final file = allFiles[index];
                          final willMove = foundFiles.contains(file);
                          return ListTile(
                            dense: true,
                            leading: Icon(
                              willMove
                                  ? Icons.drive_file_move
                                  : Icons.insert_drive_file,
                              size: 16,
                              color: willMove ? Colors.blue : Colors.grey,
                            ),
                            title: Text(
                              file,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: willMove
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: willMove ? Colors.blue : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: foundFiles.isEmpty
                ? null
                : () => Navigator.pop(context, true),
            child: const Text('Lanjutkan'),
          ),
        ],
      ),
    );
  }

  Future<void> _processMoving(
    String sourcePath,
    String destPath,
    List<String> filesFromApi,
  ) async {
    int successCount = 0;
    List<String> failedFiles = [];
    List<String> notFoundFiles = [];

    setState(() => _statusLog = "Sedang memproses file...");

    final sourceDir = Directory(sourcePath);

    List<FileSystemEntity> entities = [];
    try {
      entities = sourceDir.listSync();
    } catch (e) {
      _updateStatus("Error: Tidak bisa membaca folder sumber ($e)");
      return;
    }

    for (String targetFileName in filesFromApi) {
      var matchingEntities = entities.where((element) {
        return p.basename(element.path) == targetFileName;
      }).toList();

      if (matchingEntities.isEmpty) {
        notFoundFiles.add(targetFileName);
        continue;
      }

      for (var entity in matchingEntities) {
        if (entity is File) {
          try {
            final String newPath = p.join(destPath, targetFileName);

            if (File(newPath).existsSync()) {
              failedFiles.add("$targetFileName (File sudah ada di tujuan)");
              continue;
            }

            await entity.rename(newPath);
            successCount++;
          } catch (e) {
            try {
              final String newPath = p.join(destPath, targetFileName);
              await entity.copy(newPath);
              await entity.delete();
              successCount++;
            } catch (copyError) {
              failedFiles.add("$targetFileName (Gagal: $copyError)");
            }
          }
        }
      }
    }

    // Save to history
    try {
      final history = FileMoverHistory(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        fileNames: filesFromApi,
        extension: _selectedExtension,
        successCount: successCount,
        failedFiles: failedFiles,
        notFoundFiles: notFoundFiles,
      );
      await locator<SaveFileMoverHistory>().execute(history);
      await _loadHistories();
    } catch (e) {
      debugPrint('Failed to save history: $e');
    }

    _updateStatus("Proses Selesai.");
    _showResultDialog(successCount, failedFiles, notFoundFiles);
  }

  void _updateStatus(String msg) {
    if (mounted) setState(() => _statusLog = msg);
  }

  void _showResultDialog(
    int success,
    List<String> failed,
    List<String> notFound,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Laporan Pemindahan"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                "✅ Berhasil dipindah: $success file",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),

              if (failed.isNotEmpty) ...[
                const Text(
                  "❌ Gagal Memindah:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...failed.map(
                  (e) => Text(
                    "- $e",
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (notFound.isNotEmpty) ...[
                const Text(
                  "⚠️ Tidak Ditemukan di Folder Sumber:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...notFound.map(
                  (e) => Text(
                    "- $e",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waven Mover"),
        actions: [
          if (_histories.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Hapus Semua History',
              onPressed: _clearHistory,
            ),
        ],
      ),
      body: isSmall
          ? SingleChildScrollView(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Masukkan Nama File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _fileNamesController,
                          decoration: const InputDecoration(
                            hintText:
                                "SWV00201, SWV00032, SWV00049 (pisahkan dengan koma)",
                            border: OutlineInputBorder(),
                            helperText: "Contoh: SWV00201, SWV00032, SWV00049",
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
            
                        const Text(
                          "Pilih Ekstensi File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedExtension,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: _availableExtensions.map((ext) {
                            return DropdownMenuItem(value: ext, child: Text(ext));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedExtension = value);
                            }
                          },
                        ),
                        const SizedBox(height: 24),
            
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                          onPressed: _isProcessing ? null : findAndMoveFiles,
                          icon: _isProcessing
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.drive_file_move_outline),
                          label: Text(
                            _isProcessing
                                ? "Sedang Memproses..."
                                : "Pilih Folder & Mulai",
                          ),
                        ),
            
                        const SizedBox(height: 20),
                        Text(
                          _statusLog,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.abuDialog,
                      border: Border(left: BorderSide(color: Colors.black)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text(
                                "History Pemindahan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: _loadHistories,
                                tooltip: 'Refresh History',
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        _isLoadingHistory
                            ? const Center(child: CircularProgressIndicator())
                            : _histories.isEmpty
                            ? const Center(
                                child: Text(
                                  "Belum ada history",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: _histories.length,
                                itemBuilder: (context, index) {
                                  final history = _histories[index];
                                  return _HistoryCard(history: history);
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
          )
          : Row(
              children: [
                // Left side - Input and controls
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Masukkan Nama File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _fileNamesController,
                          decoration: const InputDecoration(
                            hintText:
                                "SWV00201, SWV00032, SWV00049 (pisahkan dengan koma)",
                            border: OutlineInputBorder(),
                            helperText: "Contoh: SWV00201, SWV00032, SWV00049",
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          "Pilih Ekstensi File",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedExtension,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: _availableExtensions.map((ext) {
                            return DropdownMenuItem(
                              value: ext,
                              child: Text(ext),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedExtension = value);
                            }
                          },
                        ),
                        const SizedBox(height: 24),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                          onPressed: _isProcessing ? null : findAndMoveFiles,
                          icon: _isProcessing
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.drive_file_move_outline),
                          label: Text(
                            _isProcessing
                                ? "Sedang Memproses..."
                                : "Pilih Folder & Mulai",
                          ),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          _statusLog,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right side - History
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColor.abuDialog,
                      border: Border(left: BorderSide(color: Colors.black)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text(
                                "History Pemindahan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: _loadHistories,
                                tooltip: 'Refresh History',
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Expanded(
                          child: _isLoadingHistory
                              ? const Center(child: CircularProgressIndicator())
                              : _histories.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Belum ada history",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: _histories.length,
                                  itemBuilder: (context, index) {
                                    final history = _histories[index];
                                    return _HistoryCard(history: history);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final FileMoverHistory history;

  const _HistoryCard({required this.history});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    final hasErrors =
        history.failedFiles.isNotEmpty || history.notFoundFiles.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  history.successCount > 0 ? Icons.check_circle : Icons.error,
                  color: history.successCount > 0 ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  dateFormat.format(history.timestamp),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Chip(
                  label: Text(history.extension),
                  backgroundColor: MyColor.hijauaccent,
                  labelStyle: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "File: ${history.fileNames.join(', ')}",
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _StatusChip(
                  label: "✅ ${history.successCount}",
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                if (history.failedFiles.isNotEmpty)
                  _StatusChip(
                    label: "❌ ${history.failedFiles.length}",
                    color: Colors.red,
                  ),
                const SizedBox(width: 8),
                if (history.notFoundFiles.isNotEmpty)
                  _StatusChip(
                    label: "⚠️ ${history.notFoundFiles.length}",
                    color: Colors.orange,
                  ),
              ],
            ),

            // Detail error section
            if (hasErrors) ...[
              const SizedBox(height: 12),
              Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  dense: true,
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(left: 16, top: 8),
                  title: const Text(
                    "Lihat Detail Error",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  children: [
                    if (history.failedFiles.isNotEmpty) ...[
                      const Row(
                        children: [
                          Icon(Icons.error, size: 14, color: Colors.red),
                          SizedBox(width: 4),
                          Text(
                            "File Gagal Dipindah:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ...history.failedFiles.map(
                        (file) => Padding(
                          padding: const EdgeInsets.only(left: 18, bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  file,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    if (history.notFoundFiles.isNotEmpty) ...[
                      const Row(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 14,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "File Tidak Ditemukan:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ...history.notFoundFiles.map(
                        (file) => Padding(
                          padding: const EdgeInsets.only(left: 18, bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.orange,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  file,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
