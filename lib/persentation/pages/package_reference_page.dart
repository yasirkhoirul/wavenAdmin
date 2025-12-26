import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/pages/photo_grapher_management_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/get_package_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/state/package_list_state.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
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
  int limit = 2;
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
    final state = ref.watch(getPackageListProvider(0, limit, search: searchQuery, sort: sortBy));
    return SingleChildScrollView(
      child: SizedBox(
        height: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderPage(judul: "Referensi Paket", icon: MyIcon.iconusers),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
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
                      MButtonWeb(
                        ontap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Fitur tambah paket belum tersedia'),
                            ),
                          );
                        },
                        teks: "Tambah",
                        icon: Icons.add,
                      ),
                    ],
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
                              ref.invalidate(
                                getPackageListProvider(1, limit),
                              );
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                    if (value == "Detail") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Detail: ${e.value.title}')),
                      );
                    }
                    if (value == "Edit") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Edit: ${e.value.title}')),
                      );
                    }
                    if (value == "Hapus") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hapus: ${e.value.title}')),
                      );
                    }
                  },
                  itemBuilder: (context) => ["Detail", "Edit", "Hapus"]
                      .map(
                        (action) =>
                            PopupMenuItem(value: action, child: Text(action)),
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
              DataCell(
                Text(currencyFormatter.format(e.value.price)),
              ),
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
                  ref.read(getPackageListProvider(0, limit, search: searchQuery, sort: sortBy).notifier).back();
                }
              : null,
          next: state.metadata?.totalPages != (state.currentPage + 1)
              ? () {
                  ref
                      .read(getPackageListProvider(0, limit, search: searchQuery, sort: sortBy).notifier)
                      .appendData();
                }
              : null,
          jumlahPage: state.metadata?.totalPages ?? 0,
          currentPage: state.currentPage+1,
        ),
      ],
    );
  }
}
