import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/admin_detail_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/provider/admin_list_provider.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_detail_booking.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class AdminManagementPage extends StatelessWidget {
  const AdminManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderPage(judul: "Admin", icon: MyIcon.iconusers),
            AdminManagementMainContent(),
          ],
        ),
      ),
    );
  }
}

class AdminManagementMainContent extends ConsumerStatefulWidget {
  const AdminManagementMainContent({super.key});

  @override
  ConsumerState<AdminManagementMainContent> createState() =>
      _AdminManagementMainContentState();
}

class _AdminManagementMainContentState
    extends ConsumerState<AdminManagementMainContent> {
  bool columnIsChecked = false;
  int limit = 2;
  int page = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userAdminGetListProvider.notifier).getListAdminData(page, limit);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userAdminGetListProvider);
    Logger().d("data admin adalah ${state.listAdmin.length}");
    Logger().d("data isreace adalah ${state.isReachedLastpage}");
    final List<DataColumn> datacolumn = [
      DataColumn(label: Text("No")),
      DataColumn(label: Text("Aksi")),
      DataColumn(label: Text("Nama Admin")),
      DataColumn(label: Text("Email")),
      DataColumn(label: Text("Role")),
      DataColumn(label: Text("Status")),
    ];
    final List<DataRow> dataRow = state.listAdmin
        .skip(page * limit)
        .take(limit)
        .toList()
        .asMap()
        .entries
        .map(
          (e) => DataRow(
            cells: [
              DataCell(Text((e.key + 1).toString())),
              DataCell(
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == "Detail") {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            Center(child: DetailAdminDialog(adminId: e.value.id)),
                      );
                    }
                  },
                  itemBuilder: (context) => ["Detail", "Hapus"]
                      .map((e) => PopupMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              ),
              DataCell(Text(e.value.name)),
              DataCell(Text(e.value.email)),
              DataCell(Text(e.value.universityName ?? '')),
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
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            OutlinedSearcchBar(onSubmitted: (value) {}),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: state.requestState == RequestState.loading
                  ? Center(child: CircularProgressIndicator())
                  : TabelContent(dataColumnUser: datacolumn, datarow: dataRow),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("jumlah baris"),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColor.abudalamcontainer,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(dataRow.length.toString())),
                        ),
                      ),

                      _buildButtonNav("Sebelumnya", () {
                        if (page > 0) {
                          setState(() {
                            page--;
                          });
                        }
                      }, page > 0 ? Colors.white : MyColor.abucontainer),
                      _buildButtonNav(
                        "Setelahnya",

                        () {
                          if (dataRow.length >= limit) {
                            setState(() {
                              page++;
                            });
                          }

                          if (!state.isReachedLastpage) {
                            ref
                                .read(userAdminGetListProvider.notifier)
                                .appendAdminData(page, limit);
                          }
                        },
                        dataRow.length >= limit
                            ? Colors.white
                            : MyColor.abucontainer,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildButtonNav(String label, VoidCallback? ontap, Color color) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.abudalamcontainer,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(label, style: GoogleFonts.robotoFlex(color: color)),
          ),
        ),
      ),
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

class DetailAdminDialog extends ConsumerWidget {
  final String adminId;
  const DetailAdminDialog({super.key, required this.adminId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminDetailAsync = ref.watch(adminDetailProvider(adminId));
    return Card(
      color: MyColor.abuDialog,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 400,
          width: 700,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Admin Detail",
                    style: GoogleFonts.robotoFlex(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: adminDetailAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (e, _) => Center(
                      child: Text(
                        'Error: $e',
                        style: GoogleFonts.robotoFlex(color: Colors.white),
                      ),
                    ),
                    data: (detail) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: Column(
                              spacing: 10,
                              children: [
                                ItemDetailOutline(
                                  judul: 'Nama Admin',
                                  sub: Text(
                                    detail.name,
                                    style: GoogleFonts.robotoFlex(
                                      color: MyColor.abuinactivetulisan,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                                ItemDetailOutline(
                                  judul: 'email',
                                  sub: Text(
                                    detail.email,
                                    style: GoogleFonts.robotoFlex(
                                      color: MyColor.abuinactivetulisan,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                                ItemDetailOutline(
                                  judul: 'No Hp',
                                  sub: Text(
                                    detail.phoneNumber ?? '-',
                                    style: GoogleFonts.robotoFlex(
                                      color: MyColor.hijauaccent,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ItemDetail(
                              judul: "Status",
                              sub: DropDownOutlined(
                                items: [
                                  DropdownMenuItem(
                                    value: Status.aktif.name,
                                    child: Text('Aktif'),
                                  ),
                                  DropdownMenuItem(
                                    value: Status.tidakaktif.name,
                                    child: Text('Tidak Aktif'),
                                  ),
                                ], initialValue: detail.isActive?Status.aktif.name:Status.tidakaktif.name, onChanged: (value) {  },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


