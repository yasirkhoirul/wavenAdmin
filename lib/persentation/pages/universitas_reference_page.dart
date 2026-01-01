import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/create_university_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/delete_university_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/get_university_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/state/universitas_list_state.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/dialog/university_form_dialog.dart';
import 'package:wavenadmin/persentation/widget/footer_tabel.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
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
  int limit = 2;
  bool isAsc = true;
  Sort? sortBy;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getUniversityListProvider(0, limit,search: searchController.text,sort: sortBy));
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: OutlinedSearcchBar(
                            onSubmitted: (value) {
                              setState(() {
                                searchController.text = value;
                              });
                            },
                            controller: searchController,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.invalidate(
                              getUniversityListProvider(
                                0, limit,search: searchController.text,sort: sortBy
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
                              builder: (context) => DialogTambahUniv(),
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
                              ref.invalidate(
                                getUniversityListProvider(1, limit),
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

  Widget _buildTable(BuildContext context, UniversitasListState state) {
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
            ref.invalidate(
              getUniversityListProvider(
                0,
                limit,
                search: searchController.text,
                sort: sortBy,
              ),
            );
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
            ref.invalidate(
              getUniversityListProvider(
                0,
                limit,
                search: searchController.text,
                sort: sortBy,
              ),
            );
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
                          child: UniversityFormDialog(universityId: e.value.id),
                        ),
                      );
                    }
                    
                    if (value == "Hapus") {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: Text('Konfirmasi Hapus'),
                          content: Text(
                            'Apakah Anda yakin ingin menghapus ${e.value.name}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(dialogContext).pop(),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(dialogContext).pop();
                                
                                try {
                                  await ref.read(
                                    deleteUniversityProvider(e.value.id).future,
                                  );

                                  if (!context.mounted) return;

                                  // Refresh list
                                  ref.invalidate(
                                    getUniversityListProvider(0, limit),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Universitas berhasil dihapus',
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Gagal menghapus: $e'),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => ["Detail", "Hapus"]
                      .map(
                        (action) =>
                            PopupMenuItem(value: action, child: Text(action)),
                      )
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
          child: TabelContent(dataColumnUser: dataColumns, datarow: dataRows),
        ),
        SizedBox(height: 20),
        FooterTabel(
          back: state.currentPage > 0
              ? () {
                  ref.read(getUniversityListProvider(0, limit,search: searchController.text,sort: sortBy).notifier).back();
                }
              : null,
          next: state.metadata?.totalPages != (state.currentPage + 1)
              ? () {
                  ref
                      .read(getUniversityListProvider(0, limit,search: searchController.text,sort: sortBy).notifier)
                      .appendData(
                        
                      );
                }
              : null,
          jumlahPage: state.metadata?.totalPages ?? 0,
          currentPage: state.currentPage+1,
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
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}

class DialogTambahUniv extends ConsumerStatefulWidget {
  const DialogTambahUniv({super.key});

  @override
  ConsumerState<DialogTambahUniv> createState() => _DialogTambahUnivState();
}

class _DialogTambahUnivState extends ConsumerState<DialogTambahUniv> {
  final TextEditingController nama = TextEditingController();
  final TextEditingController singkatan = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    nama.dispose();
    singkatan.dispose();
    alamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 800,
        height: 600,
        child: Center(
          child: Card(
            color: MyColor.abuDialog,
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tambah Universitas",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    ItemDetailInputOutline(
                      judul: "Nama Universitas",
                      controller: nama,
                      validator: _validatorCheck,
                    ),
                    ItemDetailInputOutline(
                      judul: "Singkatan",
                      controller: singkatan,
                      validator: _validatorCheck,
                    ),
                    ItemDetailInputOutline(
                      judul: "Alamat",
                      controller: alamat,
                      validator: _validatorCheck,
                    ),
                    _isLoading
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : LBUttonMobile(
                            ontap: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                try {
                                  final dataready = UniversityDetail(
                                    id: '',
                                    name: nama.text,
                                    briefName: singkatan.text,
                                    address: alamat.text,
                                    isActive: true,
                                    createdAt: '',
                                  );

                                  await ref.read(
                                    createUniversityProvider(dataready).future,
                                  );

                                  if (!context.mounted) return;

                                  // Refresh list
                                  ref.invalidate(
                                    getUniversityListProvider(0, 10),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content:
                                          Text('Universitas berhasil ditambahkan'),
                                    ),
                                  );

                                  Navigator.of(context).pop();
                                } catch (e) {
                                  setState(() {
                                    _isLoading = false;
                                  });

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Terjadi Kesalahan: $e'),
                                    ),
                                  );
                                }
                              }
                            },
                            teks: "Simpan",
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatorCheck(String? value) {
    if (value == null || value.isEmpty) {
      return "field tidak boleh kosong";
    }
    return null;
  }
}
