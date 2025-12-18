import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class Pengaturan extends StatelessWidget {
  const Pengaturan({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FileMoverPage(),
    );
  }
}

class FileMoverPage extends StatefulWidget {
  const FileMoverPage({super.key});

  @override
  State<FileMoverPage> createState() => _FileMoverPageState();
}

class _FileMoverPageState extends State<FileMoverPage> {
  // Anggap ini data dari API (List nama file yang dicari)
  final List<String> filesFromApi = [
    'SWV00201.jpg',
    'SWV00032.jpg',
    'SWV00049.jpg',
    'SWV00067.jpg', // Contoh file yang mungkin tidak ada
  ];

  String _statusLog = "Siap.";
  bool _isProcessing = false;

  Future<void> findAndMoveFiles() async {
    setState(() {
      _isProcessing = true;
      _statusLog = "Menunggu pemilihan folder...";
    });

    try {
      // 1. Pilih Folder SUMBER
      String? sourcePath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: "Pilih Folder SUMBER (Asal File)",
        lockParentWindow: true,
      );

      if (sourcePath == null) {
        _updateStatus("Batal memilih folder sumber.");
        return;
      }

      // 2. Pilih Folder TUJUAN
      String? destPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: "Pilih Folder TUJUAN (Tempat Simpan)",
        lockParentWindow: true,
      );

      if (destPath == null) {
        _updateStatus("Batal memilih folder tujuan.");
        return;
      }

      // Mulai Proses Pemindahan
      await _processMoving(sourcePath, destPath);

    } catch (e) {
      _updateStatus("Terjadi kesalahan sistem: $e");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _processMoving(String sourcePath, String destPath) async {
    int successCount = 0;
    List<String> failedFiles = []; // Menyimpan list file yang gagal
    List<String> notFoundFiles = []; // Menyimpan list file dari API yang tidak ketemu

    setState(() => _statusLog = "Sedang memproses file...");

    final sourceDir = Directory(sourcePath);
    
    // Ambil semua file yang ada di folder sumber dulu
    List<FileSystemEntity> entities = [];
    try {
      entities = sourceDir.listSync();
    } catch (e) {
      _updateStatus("Error: Tidak bisa membaca folder sumber ($e)");
      return;
    }

    // Loop berdasarkan list dari API
    for (String targetFileName in filesFromApi) {
      // Cari apakah file API ini ada di folder sumber
      // Kita pakai where agar case-insensitive atau presisi
      var matchingEntities = entities.where((element) {
        return p.basename(element.path) == targetFileName;
      }).toList();

      if (matchingEntities.isEmpty) {
        notFoundFiles.add(targetFileName);
        continue;
      }

      // Jika file ketemu, coba pindahkan
      for (var entity in matchingEntities) {
        if (entity is File) {
          try {
            final String newPath = p.join(destPath, targetFileName);
            
            // Cek jika file dengan nama sama sudah ada di tujuan (opsional)
            if (File(newPath).existsSync()) {
               failedFiles.add("$targetFileName (File sudah ada di tujuan)");
               continue;
            }

            // Pindahkan (Rename path)
            await entity.rename(newPath);
            successCount++;
            
          } catch (e) {
            // Jika gagal rename (misal beda partisi drive C ke D), coba Copy + Delete
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

    _updateStatus("Proses Selesai.");
    _showResultDialog(successCount, failedFiles, notFoundFiles);
  }

  void _updateStatus(String msg) {
    if (mounted) setState(() => _statusLog = msg);
  }

  // Menampilkan Popup hasil laporan
  void _showResultDialog(int success, List<String> failed, List<String> notFound) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Laporan Pemindahan"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text("✅ Berhasil dipindah: $success file", 
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 10),
              
              if (failed.isNotEmpty) ...[
                const Text("❌ Gagal Memindah:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...failed.map((e) => Text("- $e", style: const TextStyle(fontSize: 12, color: Colors.red))),
                const SizedBox(height: 10),
              ],

              if (notFound.isNotEmpty) ...[
                const Text("⚠️ Tidak Ditemukan di Folder Sumber:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...notFound.map((e) => Text("- $e", style: const TextStyle(fontSize: 12, color: Colors.grey))),
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
    return Scaffold(
      appBar: AppBar(title: const Text("File Mover Pro")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Target File dari API:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(filesFromApi.join(', '), textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
              
              const SizedBox(height: 40),
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                onPressed: _isProcessing ? null : findAndMoveFiles,
                icon: _isProcessing 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
                  : const Icon(Icons.drive_file_move_outline),
                label: Text(_isProcessing ? "Sedang Memproses..." : "Pilih Folder & Mulai"),
              ),
              
              const SizedBox(height: 20),
              Text(_statusLog, style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
}