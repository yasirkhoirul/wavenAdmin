import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/pages/photo_grapher_management_page.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/get_university_list_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/university_form_dialog.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class UniversitasReferencePage extends ConsumerStatefulWidget {
  const UniversitasReferencePage({super.key});

  @override
  ConsumerState<UniversitasReferencePage> createState() =>
      _UniversitasReferencePageState();
}

class _UniversitasReferencePageState
    extends ConsumerState<UniversitasReferencePage> {
  final TextEditingController searchController = TextEditingController();
  int limit = 10;
  bool isAsc = true;
  Sort? sortBy;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getUniversityListProvider(0, limit));

    return SingleChildScrollView(
      child: SizedBox(
        height: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderPage(judul: "Referensi Universitas", icon: MyIcon.iconusers),
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
                            ref.invalidate(getUniversityListProvider(0, limit, search: value, sort: sortBy));
                          },
                          controller: searchController,
                        ),
                      ),
                      MButtonWeb(
                        ontap: () {
                          // TODO: Implement add university
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Fitur tambah universitas belum tersedia')),
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
                              ref.invalidate(getUniversityListProvider(0, limit));
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

  Widget _buildTable(BuildContext context, state) {
    final List<DataColumn> dataColumns = [
      DataColumn(label: Text("No")),
      DataColumn(label: Text("Aksi")),
      DataColumn(
        label: ColumnSort(
          label: "Nama Universitas",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = isAsc ? Sort.asc : Sort.desc;
            });
            ref.invalidate(getUniversityListProvider(
              0,
              limit,
              search: searchController.text,
              sort: sortBy,
            ));
          },
        ),
      ),
      DataColumn(label: Text("Singkatan")),
      DataColumn(label: Text("Alamat")),
      DataColumn(
        label: ColumnSort(
          label: "Status",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = isAsc ? Sort.asc : Sort.desc;
            });
            ref.invalidate(getUniversityListProvider(
              0,
              limit,
              search: searchController.text,
              sort: sortBy,
            ));
          },
        ),
      ),
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
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: UniversityFormDialog(
                            universityId: e.value.id,
                          ),
                        ),
                      );
                    }
                    if (value == "Edit") {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: UniversityFormDialog(
                            universityId: e.value.id,
                          ),
                        ),
                      );
                    }
                    if (value == "Hapus") {
                      // TODO: Delete confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hapus: ${e.value.name}')),
                      );
                    }
                  },
                  itemBuilder: (context) => ["Detail", "Edit", "Hapus"]
                      .map((action) => PopupMenuItem(
                            value: action,
                            child: Text(action),
                          ))
                      .toList(),
                ),
              ),
              DataCell(Text(e.value.name)),
              DataCell(Text(e.value.briefName)),
              DataCell(
                SizedBox(
                  width: 200,
                  child: Text(
                    e.value.address,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              DataCell(
                e.value.isActive
                    ? _buildStatusChip("Aktif", color: MyColor.hijauaccent)
                    : _buildStatusChip(
                        "Tidak Aktif",
                        color: MyColor.abudalamcontainer,
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
          child: TabelContent(
            dataColumnUser: dataColumns,
            datarow: dataRows,
          ),
        ),
        SizedBox(height: 20),
        FooterTabel(
          back: state.currentPage > 0
              ? () {
                  ref.read(getUniversityListProvider(0, limit).notifier).back();
                }
              : null,
          next: state.metadata?.totalPages != (state.currentPage + 1)
              ? () {
                  ref.read(getUniversityListProvider(0, limit).notifier).appendData(
                        state.page + 1,
                        limit,
                        search: searchController.text,
                        sort: sortBy,
                      );
                }
              : null,
          jumlahPage: state.metadata?.totalPages ?? 0,
          currentPage: state.currentPage + 1,
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label, {Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? MyColor.hijauaccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}