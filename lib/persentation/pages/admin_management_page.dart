import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/detail_admin.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/admin/admin_detail_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/admin/admin_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/admin/admin_mutation_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
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
  final TextEditingController searchController = TextEditingController();
  int limit = 2;
  bool isAsc = true;
  SortAdmin sortBy = SortAdmin.name;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(userAdminGetListProvider.notifier)
          .getListAdminData(
            limit,
            sort: isAsc ? Sort.asc : Sort.desc,
            sortAdmin: sortBy,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userAdminGetListProvider);
    
    final List<DataColumn> datacolumn = [
      DataColumn(label: Text("No")),
      DataColumn(label: Text("Aksi")),
      DataColumn(
        label: ColumnSort(
          label: "Nama Admin",
          onTap: () {
            setState(() {
              sortBy = SortAdmin.name;
              isAsc = !isAsc;
            });
            ref
                .read(userAdminGetListProvider.notifier)
                .getListAdminData(
                  limit,
                  sort: isAsc ? Sort.asc : Sort.desc,
                  sortAdmin: sortBy,
                );
          },
        ),
      ),
      DataColumn(label: Text("Email")),
      DataColumn(
        label: ColumnSort(
          label: "Role",
          onTap: () {
            setState(() {
              sortBy = SortAdmin.type;
              isAsc = !isAsc;
            });
            ref
                .read(userAdminGetListProvider.notifier)
                .getListAdminData(
                  limit,
                  sort: isAsc ? Sort.asc : Sort.desc,
                  sortAdmin: sortBy,
                );
          },
        ),
      ),
      DataColumn(
        label: ColumnSort(
          label: "Status",
          onTap: () {
            setState(() {
              sortBy = SortAdmin.is_active;
              isAsc = !isAsc;
            });
            ref
                .read(userAdminGetListProvider.notifier)
                .getListAdminData(
                  limit,
                  sort: isAsc ? Sort.asc : Sort.desc,
                  sortAdmin: sortBy,
                );
          },
        ),
      ),
    ];
    final List<DataRow> dataRow = state.listAdmin
        .skip(state.currentpage! * limit)
        .take(limit)
        .toList()
        .asMap()
        .entries
        .map(
          (e) => DataRow(
            cells: [
              DataCell(
                Text(((state.currentpage! * limit) + e.key + 1).toString()),
              ),
              DataCell(
                PopupMenuButton(
                  onSelected: (value) async {
                    if (value == "Detail") {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: AdminFormDialog(
                            adminId: e.value.id,
                            limit: limit,
                          ),
                        ),
                      );
                    }
                    if (value == "Hapus") {
                      try {
                        await ref
                            .read(adminMutationProvider(e.value.id).notifier)
                            .deleteAdmin(e.value.id);

                        ref
                            .read(userAdminGetListProvider.notifier)
                            .getListAdminData(limit);
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Gagal hapus: $e'),
                          ),
                        );
                      }
                    }
                  },
                  itemBuilder: (context) => ["Detail", "Hapus"]
                      .map((e) => PopupMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              ),
              DataCell(Text(e.value.name)),
              DataCell(Text(e.value.email)),
              DataCell(Text(e.value.role ?? '')),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: OutlinedSearcchBar(
                    onSubmitted: (value) {
                      ref
                          .read(userAdminGetListProvider.notifier)
                          .getListAdminData(
                            limit,
                            search: value,
                            sort: isAsc ? Sort.asc : Sort.desc,
                          );
                    },
                    controller: searchController,
                  ),
                ),
                MButtonWeb(
                  ontap: () async {
                    await showDialog<DetailAdmin>(
                      context: context,
                      builder: (context) =>
                          Center(child: AdminFormDialog(limit: limit)),
                    );
                  },
                  teks: "Tambah",
                  icon: Icons.add,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: state.requestState == RequestState.loading
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8127,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : TabelContent(dataColumnUser: datacolumn, datarow: dataRow),
            ),
            FooterTabel(
              back: state.currentpage! > 0
                  ? () {
                      ref.read(userAdminGetListProvider.notifier).back();
                    }
                  : null,
              next: state.metadata?.totalPages != state.currentpage && state.requestState != RequestState.loading
                  ? () {
                      ref
                          .read(userAdminGetListProvider.notifier)
                          .appendAdminData(
                            limit,
                            search: searchController.text,
                            sort: isAsc ? Sort.asc : Sort.desc,
                            sortAdmin: sortBy,
                          );
                    }
                  : null,
              jumlahPage: state.metadata?.totalPages ?? 0,
              currentPage: state.currentpage! + 1,
            ),
          ],
        );
      },
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

class AdminFormDialog extends ConsumerStatefulWidget {
  final String? adminId;
  final int limit;
  const AdminFormDialog({super.key, this.adminId, required this.limit});

  @override
  ConsumerState<AdminFormDialog> createState() => _AdminFormDialogState();
}

class _AdminFormDialogState extends ConsumerState<AdminFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernammeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController namedController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _statusValue = Status.aktif.name;
  DateTime _createdAt = DateTime.now();
  bool _seededFromApi = false;

  bool get _isCreate => widget.adminId == null;

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  void _seedFromDetailOnce(DetailAdmin detail) {
    if (_seededFromApi) return;
    _seededFromApi = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      usernammeController.text = detail.username;
      emailController.text = detail.email;
      phoneController.text = detail.phoneNumber ?? '';
      namedController.text = detail.name;

      setState(() {
        _statusValue = detail.isActive
            ? Status.aktif.name
            : Status.tidakaktif.name;
        _createdAt = detail.createdAt;
      });
    });
  }

  Widget _buildFormFields(DetailAdmin? detail) {
    if (detail != null) {
      _seedFromDetailOnce(detail);
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: Column(
              spacing: 10,
              children: [
                ItemDetailInputOutline(
                  judul: 'Username',
                  controller: usernammeController,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'Nama Admin',
                  controller: namedController,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _requiredValidator,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              spacing: 10,
              children: [
                ItemDetailInputOutlineGreenText(
                  judul: 'No Hp',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: _requiredValidator,
                ),
                detail != null
                    ? ItemDetail(
                        judul: "Status",
                        sub: DropDownOutlined(
                          items: const [
                            DropdownMenuItem(
                              value: 'aktif',
                              child: Text('Aktif'),
                            ),
                            DropdownMenuItem(
                              value: 'tidakaktif',
                              child: Text('Tidak Aktif'),
                            ),
                          ],
                          initialValue: _statusValue,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Tidak boleh kosong';
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _statusValue = value ?? Status.aktif.name;
                            });
                          },
                        ),
                      )
                    : ItemDetailInputOutlineGreenText(
                        judul: "Password",
                        controller: passwordController,
                        validator: _requiredValidator,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernammeController.dispose();
    emailController.dispose();
    phoneController.dispose();
    namedController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mutationKey = widget.adminId ?? '';
    final adminDetailAsync = _isCreate
        ? ref.watch(adminMutationProvider(mutationKey))
        : ref.watch(adminDetailProvider(widget.adminId!));
    return Card(
      color: MyColor.abuDialog,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          width: 700,
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
                      _isCreate ? "Tambah Admin" : "Admin Detail",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: adminDetailAsync is! AsyncValue<DetailAdmin>
                        ? adminDetailAsync.when(
                            data: (data) => _buildFormFields(null),
                            error: (error, stackTrace) {
                              return Center(child: Text("error"));
                            },
                            loading: () =>
                                Center(child: CircularProgressIndicator()),
                          )
                        : adminDetailAsync.when(
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
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MButtonWeb(
                          ontap: () async {
                            final isValid =
                                _formKey.currentState?.validate() ?? false;
                            if (!isValid) return;

                            if (_isCreate) {
                              try {
                                await ref
                                    .read(
                                      adminMutationProvider(
                                        widget.adminId ?? '',
                                      ).notifier,
                                    )
                                    .createAdmin(
                                      DetailAdmin(
                                        '',
                                        password: passwordController.text
                                            .trim(),
                                        usernammeController.text.trim(),
                                        emailController.text.trim(),
                                        namedController.text.trim(),
                                        phoneController.text.trim(),
                                        false,
                                        DateTime.now(),
                                      ),
                                    );
                                ref
                                    .read(userAdminGetListProvider.notifier)
                                    .getListAdminData(widget.limit);
                              } catch (error) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(error.toString()),
                                  ),
                                );
                              }
                            } else {
                              try {
                                await ref
                                    .read(
                                      adminDetailProvider(
                                        widget.adminId!,
                                      ).notifier,
                                    )
                                    .onUpdate(
                                      DetailAdmin(
                                        widget.adminId!,
                                        usernammeController.text.trim(),
                                        emailController.text.trim(),
                                        namedController.text.trim(),
                                        phoneController.text.trim(),
                                        _statusValue == Status.aktif.name,
                                        _createdAt,
                                      ),
                                    );

                                if (context.mounted) {
                                  ref
                                      .read(userAdminGetListProvider.notifier)
                                      .getListAdminData(widget.limit);
                                  Navigator.of(context).pop();
                                }
                              } catch (e) {
                                if (!context.mounted) return;
                                if (e.toString().contains(
                                  "user not authorized",
                                )) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Maaf Anda Tidak Berhak Melakukan Tindakan Tersebut",
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text("Terjadi Kesalahan $e"),
                                    ),
                                  );
                                }
                              }
                            }
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
