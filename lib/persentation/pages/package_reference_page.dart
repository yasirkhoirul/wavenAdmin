import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/create_package_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/delete_package_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/get_package_detial_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/get_package_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/porto/porto_mutation.dart';
import 'package:wavenadmin/persentation/riverpod/state/package_list_state.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/footer_tabel.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class PackageReferencePage extends ConsumerStatefulWidget {
  const PackageReferencePage({super.key});

  @override
  ConsumerState<PackageReferencePage> createState() =>
      _PackageReferencePageState();
}

class _PackageReferencePageState extends ConsumerState<PackageReferencePage> {
  final TextEditingController searchController = TextEditingController();
  int limit = 10;
  bool isAsc = true;
  Sort? sortBy;
  String searchQuery = '';

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      getPackageListProvider(0, limit, search: searchQuery, sort: sortBy),
    );
    return SingleChildScrollView(
      child: SizedBox(
        height: 1200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderPage(judul: "Referensi Paket", icon: MyIcon.iconreferensi),
              SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: OutlinedSearcchBar(
                            onSubmitted: (value) {
                              Logger().d("ini dietakn");
                              setState(() {
                                searchQuery = value;
                              });
                              Logger().d("ini dietakn selesai");
                            },
                            controller: searchController,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.invalidate(
                              getPackageListProvider(
                                0,
                                limit,
                                search: searchQuery,
                                sort: sortBy,
                              ),
                            );
                          },
                          icon: Icon(Icons.refresh, color: MyColor.hijauaccent),
                          tooltip: 'Refresh',
                        ),
                        MButtonWeb(
                          ontap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const DialogCreatePackage(),
                            );
                          },
                          teks: "Tambah",
                          icon: Icons.add,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  state.when(
                    data: (data) => _buildTable(context, data),
                    loading: () => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8127,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (error, stack) => Center(
                      child: Column(
                        children: [
                          Text('Error: $error'),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(getPackageListProvider(1, limit));
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, PackageListState state) {
    final List<DataColumn> dataColumns = [
      DataColumn(label: Text("No")),
      DataColumn(label: Text("Aksi")),
      DataColumn(label: Text("Banner")),
      DataColumn(
        label: ColumnSort(
          label: "Judul Paket",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = isAsc ? Sort.asc : Sort.desc;
            });
          },
        ),
      ),
      DataColumn(
        label: ColumnSort(
          label: "Harga",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = isAsc ? Sort.asc : Sort.desc;
            });
          },
        ),
      ),
      DataColumn(label: Text("Deskripsi")),
    ];

    final List<DataRow> dataRows = state.item
        .skip(state.currentPage * limit)
        .take(limit)
        .toList()
        .asMap()
        .entries
        .map<DataRow>(
          (e) => DataRow(
            cells: [
              DataCell(
                Text(((state.currentPage * limit) + e.key + 1).toString()),
              ),
              DataCell(
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == "Manage Porto") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogPorto(packageId: e.value.id);
                        },
                      );
                    }
                    if (value == "Detail") {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            DialogDetail(idPackage: e.value.id),
                      );
                    }
                    if (value == "Edit") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Edit: ${e.value.title}')),
                      );
                    }
                    if (value == "Hapus") {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Konfirmasi Hapus'),
                          content: Text(
                            'Apakah Anda yakin ingin menghapus paket "${e.value.title}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(dialogContext);

                                BuildContext? loadingDialogContext;
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (ctx) {
                                    loadingDialogContext = ctx;
                                    return const AlertDialog(
                                      content: Row(
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(width: 20),
                                          Text('Menghapus paket...'),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                try {
                                  await ref
                                      .read(deletePackageProvider.notifier)
                                      .deletePackage(e.value.id);

                                  // Close loading dialog using stored context
                                  if (loadingDialogContext != null &&
                                      loadingDialogContext!.mounted) {
                                    Navigator.pop(loadingDialogContext!);
                                  }

                                  // Success - show message and refresh list
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Paket berhasil dihapus'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    ref.invalidate(getPackageListProvider);
                                  }
                                } catch (e) {
                                  // Close loading dialog on error
                                  if (loadingDialogContext != null &&
                                      loadingDialogContext!.mounted) {
                                    Navigator.pop(loadingDialogContext!);
                                  }

                                  // Show error message
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) =>
                      ["Detail", "Edit", "Hapus", "Manage Porto"]
                          .map(
                            (action) => PopupMenuItem(
                              value: action,
                              child: Text(action),
                            ),
                          )
                          .toList(),
                ),
              ),
              DataCell(
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    e.value.bannerUrl,
                    width: 80,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 50,
                      color: Colors.grey[300],
                      child: Icon(Icons.image_not_supported, size: 30),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 200,
                  child: Text(
                    e.value.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              DataCell(Text(currencyFormatter.format(e.value.price))),
              DataCell(
                SizedBox(
                  width: 250,
                  child: Text(
                    e.value.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        )
        .toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: TabelContent(dataColumnUser: dataColumns, datarow: dataRows),
        ),
        SizedBox(height: 20),
        FooterTabel(
          back: state.currentPage > 0
              ? () {
                  ref
                      .read(
                        getPackageListProvider(
                          0,
                          limit,
                          search: searchQuery,
                          sort: sortBy,
                        ).notifier,
                      )
                      .back();
                }
              : null,
          next: state.metadata?.totalPages != (state.currentPage + 1)
              ? () {
                  ref
                      .read(
                        getPackageListProvider(
                          0,
                          limit,
                          search: searchQuery,
                          sort: sortBy,
                        ).notifier,
                      )
                      .appendData();
                }
              : null,
          jumlahPage: state.metadata?.totalPages ?? 0,
          currentPage: state.currentPage + 1,
        ),
      ],
    );
  }
}

class DialogPorto extends ConsumerStatefulWidget {
  final String packageId;

  const DialogPorto({super.key, required this.packageId});

  @override
  ConsumerState<DialogPorto> createState() => _DialogPortoState();
}

class _DialogPortoState extends ConsumerState<DialogPorto> {
 
  void _deleteImage(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus gambar ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              ref.read(portoMutationProvider(widget.packageId).notifier).deletePortoOne(id);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _addImage() async {
    final imagePicker = ImagePicker();
    final data = await imagePicker.pickImage(source: ImageSource.gallery);
    if (data != null) {
      ref.read(portoMutationProvider(widget.packageId).notifier).addPortoOne(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(portoMutationProvider(widget.packageId));
    return Center(
      child: Card(
        color: MyColor.abuDialog,
        child: SizedBox(
          height: 800,
          width: 900,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Manage Portfolio",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _addImage,
                          icon: Icon(
                            Icons.add_photo_alternate,
                            color: MyColor.hijauaccent,
                          ),
                          tooltip: 'Tambah Gambar',
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                state.when(
                  data: (data) => Expanded(
                    child: data.portfolios.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_library_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Belum ada portfolio',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1,
                                ),
                            itemCount: data.portfolios.length,
                            itemBuilder: (context, index) {
                              final image = data.portfolios[index];
                              return _PortfolioImageItem(
                                id: image.id,
                                url: image.url,
                                onDelete: () => _deleteImage(image.id),
                              );
                            },
                          ),
                  ),
                  error: (Object error, StackTrace stackTrace) {
                    return Column(
                      children: [
                        Text(error.toString()),
                        MButtonMobile(ontap: (){
                          ref.invalidate(portoMutationProvider(widget.packageId));
                        }, teks: "Coba Lagi")
                      ],
                    );
                  },
                  loading: () {
                    return Center(child: CircularProgressIndicator(),);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PortfolioImageItem extends StatelessWidget {
  final String id;
  final String url;
  final VoidCallback onDelete;

  const _PortfolioImageItem({
    required this.id,
    required this.url,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColor.abudalamcontainer, width: 1),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[800],
                child: const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogDetail extends ConsumerStatefulWidget {
  final String idPackage;

  const DialogDetail({super.key, required this.idPackage});

  @override
  ConsumerState<DialogDetail> createState() => _DialogDetailState();
}

class _DialogDetailState extends ConsumerState<DialogDetail> {
  final judulController = TextEditingController();
  final priceController = TextEditingController();
  final description = TextEditingController();
  bool isActive = false;
  Uint8List? image;
  List<PackageBenefit> benefits = [];
  bool _isInitialized = false;

  void init(PackageDetailData data) {
    // Hanya init sekali atau jika idPackage berubah
    if (_isInitialized) return;

    description.text = data.description;
    judulController.text = data.title;
    priceController.text = data.price.toString();
    isActive = data.isActive;
    image = data.gambarDetail != null
        ? Uint8List.fromList(data.gambarDetail!)
        : null;
    // Load benefits dari data
    benefits = data.benefits.map((benefit) => benefit).toList();

    _isInitialized = true;
  }

  void takeImage() async {
    final imagePicker = ImagePicker();
    final data = await imagePicker.pickImage(source: ImageSource.gallery);
    if (data != null) {
      final dataready = await data.readAsBytes();
      setState(() {
        image = dataready;
      });
    }
    return;
  }

  @override
  void dispose() {
    description.dispose();
    judulController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getPackageDetialProvider(widget.idPackage));

    return Center(
      child: SizedBox(
        height: 800,
        width: 700,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Detail Package"),
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(Icons.cancel, color: Colors.white),
                    ),
                  ],
                ),
                state.when(
                  data: (data) {
                    init(data.data);

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            spacing: 20,
                            children: [
                              ItemDetailInputOutline(
                                judul: "Judul",
                                controller: judulController,
                              ),
                              InkWell(
                                onTap: () => takeImage(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColor.abudalamcontainer,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 500,
                                  width: 500,
                                  child: image == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: data.data.bannerUrl,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(15),
                                          child: Image.memory(
                                            image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                              ItemDetailInputOutlineGreenText(
                                judul: "Harga",
                                controller: priceController,
                              ),
                              ItemDetailInputOutline(
                                judul: "Deskripsi",
                                controller: description,
                              ),
                              ItemDetail(
                                judul: "Status",
                                sub: Row(
                                  children: [
                                    Switch(
                                      value: isActive,
                                      onChanged: (value) {
                                        setState(() {
                                          isActive = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              // Benefit Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Benefit/Addon',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      final controller =
                                          TextEditingController();
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Tambah Benefit'),
                                          content: TextField(
                                            controller: controller,
                                            decoration: const InputDecoration(
                                              hintText: 'Deskripsi benefit',
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => context.pop(),
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (controller
                                                    .text
                                                    .isNotEmpty) {
                                                  setState(() {
                                                    benefits.add(
                                                      PackageBenefit(
                                                        id: '',
                                                        type: 'include',
                                                        description:
                                                            controller.text,
                                                      ),
                                                    );
                                                  });
                                                }
                                                context.pop();
                                              },
                                              child: const Text('Tambah'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: MyColor.hijauaccent,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              // Display benefits dengan switch on/off
                              if (benefits.isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: benefits.length,
                                    itemBuilder: (context, index) {
                                      final benefit = benefits[index];
                                      final isIncluded =
                                          benefit.type.toUpperCase() ==
                                          'INCLUDE';

                                      return ListTile(
                                        title: Text(benefit.description),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Switch(
                                              value: isIncluded,
                                              onChanged: (value) {
                                                setState(() {
                                                  benefits[index] =
                                                      PackageBenefit(
                                                        id: benefit.id,
                                                        description:
                                                            benefit.description,
                                                        type: value
                                                            ? 'INCLUDE'
                                                            : 'EXCLUDE',
                                                      );
                                                });
                                              },
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  benefits.removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          isIncluded ? 'Included' : 'Excluded',
                                          style: TextStyle(
                                            color: isIncluded
                                                ? MyColor.hijauaccent
                                                : Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              SizedBox(height: 10),
                              MButtonWeb(
                                ontap: () {
                                  final title = judulController.text;
                                  final descriptionText = this.description.text;
                                  final priceText = priceController.text;

                                  // Validasi
                                  if (title.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Judul tidak boleh kosong',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final price = int.tryParse(priceText);
                                  if (price == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Harga harus angka'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (descriptionText.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Deskripsi tidak boleh kosong',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final packageData = PackageDetailData(
                                    id: state.value!.data.id,
                                    title: title,
                                    price: price,
                                    bannerUrl: state.value!.data.bannerUrl,
                                    description: descriptionText,
                                    isActive: isActive,
                                    createdAt: state.value!.data.createdAt,
                                    benefits: benefits
                                        .map(
                                          (e) => PackageBenefit(
                                            id: e.id,
                                            description: e.description,
                                            type: e.type.toLowerCase(),
                                          ),
                                        )
                                        .toList(),
                                    gambarDetail:
                                        state.value!.data.gambarDetail,
                                  );

                                  ref
                                      .read(
                                        getPackageDetialProvider(
                                          widget.idPackage,
                                        ).notifier,
                                      )
                                      .onUpdate(image!, packageData);
                                },
                                teks: "Simpan",
                                icon: Icons.add,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () => Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogCreatePackage extends ConsumerStatefulWidget {
  const DialogCreatePackage({super.key});

  @override
  ConsumerState<DialogCreatePackage> createState() =>
      _DialogCreatePackageState();
}

class _DialogCreatePackageState extends ConsumerState<DialogCreatePackage> {
  final judulController = TextEditingController();
  final priceController = TextEditingController();
  final description = TextEditingController();
  Uint8List? image;
  List<CreatePackageBenefit> benefits = [];

  void takeImage() async {
    final imagePicker = ImagePicker();
    final data = await imagePicker.pickImage(source: ImageSource.gallery);
    if (data != null) {
      final dataready = await data.readAsBytes();
      setState(() {
        image = dataready;
      });
    }
  }

  void addBenefit() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Benefit'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Deskripsi benefit'),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  benefits.add(
                    CreatePackageBenefit(
                      type: 'include',
                      description: controller.text,
                    ),
                  );
                });
              }
              context.pop();
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    description.dispose();
    judulController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 800,
        width: 700,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Buat Package Baru"),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.cancel, color: Colors.white),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        spacing: 20,
                        children: [
                          ItemDetailInputOutline(
                            judul: "Judul",
                            controller: judulController,
                          ),
                          InkWell(
                            onTap: () => takeImage(),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColor.abudalamcontainer,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 300,
                              width: 500,
                              child: image == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 10),
                                        Text('Pilih Gambar'),
                                      ],
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.memory(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          ItemDetailInputOutlineGreenText(
                            judul: "Harga",
                            controller: priceController,
                          ),
                          ItemDetailInputOutline(
                            judul: "Deskripsi",
                            controller: description,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Benefit/Addon',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                onPressed: addBenefit,
                                icon: Icon(
                                  Icons.add_circle,
                                  color: MyColor.hijauaccent,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          if (benefits.isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: benefits.length,
                                itemBuilder: (context, index) {
                                  final benefit = benefits[index];
                                  final isIncluded =
                                      benefit.type.toUpperCase() == 'INCLUDE';

                                  return ListTile(
                                    title: Text(benefit.description),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Switch(
                                          value: isIncluded,
                                          onChanged: (value) {
                                            setState(() {
                                              benefits[index] =
                                                  CreatePackageBenefit(
                                                    description:
                                                        benefit.description,
                                                    type: value
                                                        ? 'include'
                                                        : 'exclude',
                                                  );
                                            });
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              benefits.removeAt(index);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      isIncluded ? 'Included' : 'Excluded',
                                      style: TextStyle(
                                        color: isIncluded
                                            ? MyColor.hijauaccent
                                            : Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: 10),
                          MButtonWeb(
                            ontap: () async {
                              final title = judulController.text;
                              final descriptionText = description.text;
                              final priceText = priceController.text;

                              // Validasi
                              if (title.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Judul tidak boleh kosong'),
                                  ),
                                );
                                return;
                              }

                              if (image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Gambar harus dipilih'),
                                  ),
                                );
                                return;
                              }

                              final price = int.tryParse(priceText);
                              if (price == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Harga harus angka'),
                                  ),
                                );
                                return;
                              }

                              if (descriptionText.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Deskripsi tidak boleh kosong',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final request = CreatePackageRequest(
                                title: title,
                                description: descriptionText,
                                price: price,
                                benefits: benefits,
                              );

                              // Show loading dialog and capture its context
                              BuildContext? loadingDialogContext;
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (ctx) {
                                  loadingDialogContext = ctx;
                                  return const AlertDialog(
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 20),
                                        Text('Membuat paket...'),
                                      ],
                                    ),
                                  );
                                },
                              );

                              try {
                                await ref
                                    .read(createPackageProvider.notifier)
                                    .createPackage(request, image!);

                                // Close loading dialog using its own context
                                if (loadingDialogContext != null &&
                                    loadingDialogContext!.mounted) {
                                  Navigator.pop(loadingDialogContext!);
                                }

                                if (!mounted) return;

                                // Success - show message and refresh
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Paket berhasil dibuat'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // Invalidate package list to refresh
                                ref.invalidate(getPackageListProvider);

                                // Close create dialog
                                context.pop();
                              } catch (e) {
                                // Close loading dialog on error
                                if (loadingDialogContext != null &&
                                    loadingDialogContext!.mounted) {
                                  Navigator.pop(loadingDialogContext!);
                                }

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            teks: "Simpan",
                            icon: Icons.add,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
