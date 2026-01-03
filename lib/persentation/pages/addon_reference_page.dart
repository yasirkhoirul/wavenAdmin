import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/addon_detail_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/addon_search_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/create_addon_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/delete_addon_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/get_list_addons_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/footer_tabel.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/mychip.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class AddonReferencePage extends ConsumerStatefulWidget {
  const AddonReferencePage({super.key});

  @override
  ConsumerState<AddonReferencePage> createState() => _AddonReferencePageState();
}

class _AddonReferencePageState extends ConsumerState<AddonReferencePage> {
  final TextEditingController searchController = TextEditingController();
  final limit = 10;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(addonSearchProvider);
    final state = ref.watch(
      getListAddonsProvider(0, limit, search: searchQuery),
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            HeaderPage(judul: "Addons", icon: MyIcon.iconreferensi),
            state.when(
              data: (data) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainContentAddons(
                    onSubmit: (value) {
                      ref.read(addonSearchProvider.notifier).update(value.trim());
                      ref
                          .read(
                            getListAddonsProvider(
                              0,
                              limit,
                              search: value.trim(),
                            ).notifier,
                          )
                          .refresh(0, limit, search: value.trim());
                    },
                  searchController: searchController,
                  limit: limit,
                  dataList: data,
                ),
              ),
              error: (error, stackTrace) => Column(
                children: [
                  Text("Terjadi  error"),
                  MButtonMobile(
                    ontap: () {
                      ref.read(addonSearchProvider.notifier).update('');
                      ref.invalidate(
                        getListAddonsProvider(
                          0,
                          limit,
                          search: searchQuery,
                        ),
                      );
                    },
                    teks: error.toString(),
                  ),
                ],
              ),
              loading: () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainContentAddons extends ConsumerWidget {
  final TextEditingController searchController;
  final int limit;
  final Function(String) onSubmit;
  final ListAddons dataList;
  const MainContentAddons({
    super.key,
    required this.searchController,
    required this.limit,
    required this.dataList, required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DataColumn> dataColum = [
      DataColumn(label: Center(child: Text("No"))),
      DataColumn(label: Center(child: Text("Aksi"))),
      DataColumn(label: Center(child: Text("Nama Addons"))),
      DataColumn(label: Center(child: Text("Harga"))),
      DataColumn(label: Center(child: Text("Status"))),
    ];
    final List<DataRow> dataRow = dataList.addons
        .skip(limit * (dataList.page - 1))
        .take(limit)
        .toList()
        .asMap()
        .entries
        .toList()
        .map(
          (e) => DataRow(
            cells: [
              DataCell(
                Text(((limit * (dataList.page - 1)) + e.key + 1).toString()),
              ),
              DataCell(
                PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    PopupMenuItem(value: "Detail", child: Text("Detail")),
                    PopupMenuItem(value: "Delete", child: Text("Delete")),
                  ],
                  onSelected: (value) {
                    if (value == "Detail") {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: AddonFormDialog(
                            addonId: e.value.id,
                            limit: limit,
                          ),
                        ),
                      );
                    } else if (value == "Delete") {
                      showDialog(
                        context: context,
                        builder: (ctx) => DeleteAddonConfirmDialog(
                          addonId: e.value.id,
                          addonTitle: e.value.title,
                          limit: limit,
                        ),
                      );
                    }
                  },
                ),
              ),
              DataCell(Text(e.value.title)),
              DataCell(Text(e.value.price.toString())),
              DataCell(
                e.value.isActive
                    ? Mychip(label: "Aktif")
                    : Mychip(label: "Tidak Aktif", color: MyColor.oren),
              ),
            ],
          ),
        )
        .toList();
    return Column(
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: OutlinedSearcchBar(
                  onSubmitted: onSubmit,
                  controller: searchController,
                ),
              ),
              IconButton(
                onPressed: () {
                  final searchQuery = ref.read(addonSearchProvider);
                  ref
                      .read(
                        getListAddonsProvider(
                          0,
                          limit,
                          search: searchQuery,
                        ).notifier,
                      )
                      .refresh(0, limit, search: searchQuery);
                },
                icon: Icon(Icons.refresh, color: MyColor.hijauaccent),
                tooltip: 'Refresh',
              ),
              MButtonWeb(
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: CreateAddonDialog(limit: limit),
                    ),
                  );
                },
                teks: "Tambah",
                icon: Icons.add,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
          child: TabelContent(dataColumnUser: dataColum, datarow: dataRow),
        ),
        FooterTabel(
          back: dataList.page <= 1
              ? null
              : () {
                  ref
                      .read(
                        getListAddonsProvider(
                          0,
                          limit,
                          search: ref.read(addonSearchProvider),
                        ).notifier,
                      )
                      .onBack();
                },
          next: dataList.page == dataList.totalPages
              ? null
              : () {
                  ref
                      .read(
                        getListAddonsProvider(
                          0,
                          limit,
                          search: ref.read(addonSearchProvider),
                        ).notifier,
                      )
                      .onAdd(limit, search: ref.read(addonSearchProvider));
                },
          jumlahPage: dataList.totalPages,
          currentPage: dataList.page,
        ),
      ],
    );
  }
}

class AddonFormDialog extends ConsumerStatefulWidget {
  final String addonId;
  final int limit;
  const AddonFormDialog({super.key, required this.addonId, required this.limit});

  @override
  ConsumerState<AddonFormDialog> createState() => _AddonFormDialogState();
}

class _AddonFormDialogState extends ConsumerState<AddonFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  
  String _isActive = 'true';
  bool _seededFromApi = false;

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  void _seedFromDetailOnce(AddonDetail detail) {
    if (_seededFromApi) return;
    _seededFromApi = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      titleController.text = detail.title;
      priceController.text = detail.price.toString();
      setState(() {
        _isActive = detail.isActive ? 'true' : 'false';
      });
    });
  }

  Widget _buildFormFields(AddonDetail? detail) {
    if (detail != null) {
      _seedFromDetailOnce(detail);
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        spacing: 10,
        children: [
          ItemDetailInputOutline(
            judul: 'Judul Addon',
            controller: titleController,
            validator: _requiredValidator,
          ),
          ItemDetailInputOutlineGreenText(
            judul: 'Harga',
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: _requiredValidator,
          ),
          ItemDetail(
            judul: "Status",
            sub: DropDownOutlined(
              items: const [
                DropdownMenuItem(
                  value: 'true',
                  child: Text('Aktif'),
                ),
                DropdownMenuItem(
                  value: 'false',
                  child: Text('Tidak Aktif'),
                ),
              ],
              initialValue: _isActive,
              validator: (value) {
                if (value == null) return 'Tidak boleh kosong';
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _isActive = value ?? 'true';
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _showResultDialog(String message, {bool isSuccess = true}) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isSuccess ? 'Berhasil' : 'Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.of(context).pop();
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final addonDetailAsync = ref.watch(addonDetailProvider(widget.addonId));

    // // Listen to update state
    // ref.listen<AsyncValue<AddonDetail>>(addonDetailProvider(widget.addonId), (previous, next) {
    //   if (previous?.isLoading == true && next.hasValue) {
    //     _showResultDialog('Addon berhasil diupdate', isSuccess: true);
    //     // Refresh list
    //     final searchQuery = ref.read(addonSearchProvider);
    //     ref
    //         .read(getListAddonsProvider(0, widget.limit, search: searchQuery).notifier)
    //         .refresh(0, widget.limit, search: searchQuery);
    //   } else if (previous?.isLoading == true && next.hasError) {
    //     _showResultDialog(next.error.toString(), isSuccess: false);
    //   }
    // });

    return Card(
      color: MyColor.abuDialog,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 450,
          width: 600,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Detail Addon",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: addonDetailAsync.when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (e, _) => Center(
                        child: Text(
                          'Error: $e',
                          style: GoogleFonts.robotoFlex(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      data: (detail) => _buildFormFields(detail),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 80,
                    child: addonDetailAsync.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MButtonWeb(
                                ontap: () async {
                                  final isValid =
                                      _formKey.currentState?.validate() ?? false;
                                  if (!isValid) return;

                                  final price = int.tryParse(priceController.text.trim());
                                  if (price == null) {
                                    _showResultDialog(
                                      'Harga harus berupa angka',
                                      isSuccess: false,
                                    );
                                    return;
                                  }

                                  await ref
                                      .read(
                                        addonDetailProvider(
                                          widget.addonId,
                                        ).notifier,
                                      )
                                      .updateAddon(
                                        widget.addonId,
                                        titleController.text.trim(),
                                        price,
                                        _isActive == 'true',
                                      );
                                },
                                teks: "Simpan",
                                icon: Icons.save_alt,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Create Addon Dialog
class CreateAddonDialog extends ConsumerStatefulWidget {
  final int limit;
  const CreateAddonDialog({super.key, required this.limit});

  @override
  ConsumerState<CreateAddonDialog> createState() => _CreateAddonDialogState();
}

class _CreateAddonDialogState extends ConsumerState<CreateAddonDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _showResultDialog(String message, {bool isSuccess = true}) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isSuccess ? 'Berhasil' : 'Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.of(context).pop();
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final createState = ref.watch(createAddonProvider);

    ref.listen<AsyncValue<String?>>(createAddonProvider, (previous, next) {
      if (previous?.isLoading == true && next.hasValue && next.value != null) {
        _showResultDialog(next.value!, isSuccess: true);
        // Refresh list
        final searchQuery = ref.read(addonSearchProvider);
        ref
            .read(getListAddonsProvider(0, widget.limit, search: searchQuery).notifier)
            .refresh(0, widget.limit, search: searchQuery);
      } else if (previous?.isLoading == true && next.hasError) {
        _showResultDialog(next.error.toString(), isSuccess: false);
      }
    });

    return Card(
      color: MyColor.abuDialog,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 400,
          width: 600,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Tambah Addon",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        spacing: 10,
                        children: [
                          ItemDetailInputOutline(
                            judul: 'Judul Addon',
                            controller: titleController,
                            validator: _requiredValidator,
                          ),
                          ItemDetailInputOutlineGreenText(
                            judul: 'Harga',
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            validator: _requiredValidator,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 80,
                    child: createState.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MButtonWeb(
                                ontap: () async {
                                  final isValid =
                                      _formKey.currentState?.validate() ?? false;
                                  if (!isValid) return;

                                  final price = int.tryParse(priceController.text.trim());
                                  if (price == null) {
                                    _showResultDialog(
                                      'Harga harus berupa angka',
                                      isSuccess: false,
                                    );
                                    return;
                                  }

                                  await ref
                                      .read(createAddonProvider.notifier)
                                      .createAddon(
                                        titleController.text.trim(),
                                        price,
                                      );
                                },
                                teks: "Simpan",
                                icon: Icons.save_alt,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Delete Addon Confirmation Dialog
class DeleteAddonConfirmDialog extends ConsumerWidget {
  final String addonId;
  final String addonTitle;
  final int limit;

  const DeleteAddonConfirmDialog({
    super.key,
    required this.addonId,
    required this.addonTitle,
    required this.limit,
  });

  void _showResultDialog(BuildContext context, String message, {bool isSuccess = true}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isSuccess ? 'Berhasil' : 'Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.of(context).pop();
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteState = ref.watch(deleteAddonProvider);

    ref.listen<AsyncValue<String?>>(deleteAddonProvider, (previous, next) {
      if (previous?.isLoading == true && next.hasValue && next.value != null) {
        _showResultDialog(context, next.value!, isSuccess: true);
        // Refresh list
        final searchQuery = ref.read(addonSearchProvider);
        ref
            .read(getListAddonsProvider(0, limit, search: searchQuery).notifier)
            .refresh(0, limit, search: searchQuery);
      } else if (previous?.isLoading == true && next.hasError) {
        _showResultDialog(context, next.error.toString(), isSuccess: false);
      }
    });

    return AlertDialog(
      backgroundColor: MyColor.abuDialog,
      title: Text(
        'Konfirmasi Hapus',
        style: GoogleFonts.robotoFlex(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: deleteState.isLoading
          ? const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            )
          : Text(
              'Apakah Anda yakin ingin menghapus addon \"$addonTitle\"?',
              style: GoogleFonts.robotoFlex(color: Colors.white),
            ),
      actions: deleteState.isLoading
          ? []
          : [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () async {
                  await ref
                      .read(deleteAddonProvider.notifier)
                      .deleteAddon(addonId);
                },
                child: Text(
                  'Hapus',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
    );
  }
}
