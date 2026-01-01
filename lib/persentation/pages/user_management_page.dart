import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/data/model/update_user_request_model.dart';
import 'package:wavenadmin/domain/entity/detail_user.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/delete_user_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/update_user_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/userDetail.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/user_list_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/footer_tabel.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class UserManagementpage extends ConsumerStatefulWidget {
  const UserManagementpage({super.key});

  @override
  ConsumerState<UserManagementpage> createState() => _UserManagementpageState();
}

class _UserManagementpageState extends ConsumerState<UserManagementpage> {
  int limit = 10;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userGetListProvider);
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [HeaderPage(icon: MyIcon.iconusers, judul: "User")],
                ),
                Row(
                  children: [
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 400,
                          minWidth: 200,
                        ),
                        child: CardItemContainer(
                          aset: MyIcon.iconusers,
                          judul: "Total Users",
                          content: state.totaldata == null
                              ? "Loading"
                              : state.totaldata.toString(),
                          color: MyColor.oren,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: TabelUser(limit: limit)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabelUser extends ConsumerStatefulWidget {
  final int limit;
  const TabelUser({super.key, required this.limit});

  @override
  ConsumerState<TabelUser> createState() => _TabelUserState();
}

class _TabelUserState extends ConsumerState<TabelUser> {
  final TextEditingController searchController = TextEditingController();
  bool columnIsChecked = false;
  List<String> _idCheck = [];
  SortUser sortBy = SortUser.name;
  bool isAsc = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(userGetListProvider.notifier)
          .getListUsers(
            widget.limit,
            search: searchController.text,
            sort: isAsc ? Sort.asc : Sort.desc,
            sortBy: sortBy,
          );
    });
    ref.listenManual(userGetListProvider, (previous, next) {
      if (previous?.userData != next.userData) {
        setState(() {
          columnIsChecked = false;
          _idCheck = [];
        });
      }
    });

    ref.listenManual(deleteUserProvider, (previous, next) {
      Logger().w("ini adlaah next $next");
      Logger().w("ini adlaah prev $previous");

      if (previous?.isLoading == true && !next.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Save context and messenger reference before any operations
          final currentContext = context;
          if (!currentContext.mounted) return;

          // Get messenger instance BEFORE any dialog operations
          final messenger = ScaffoldMessenger.of(currentContext);
          FocusScope.of(currentContext).unfocus();

          next.when(
            data: (message) {
              Logger().w("ini adalh indata $message");

              // Close loading dialog if exists
              try {
                if (currentContext.mounted) {
                  Navigator.of(currentContext, rootNavigator: true).pop();
                }
              } catch (e) {
                // No dialog to close or already closed
              }

              // Wait TWO frames before showing snackbar for stable widget tree
              WidgetsBinding.instance.addPostFrameCallback((__) {
                WidgetsBinding.instance.addPostFrameCallback((___) {
                  if (currentContext.mounted) {
                    try {
                      // Use the messenger instance we got earlier
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(message ?? "berhasil dihapus"),
                        ),
                      );
                    } catch (e) {
                      Logger().w("ini adalh indata catch $e");
                      // Widget disposed, ignore
                    }
                  }
                });
              });
            },
            loading: () {},
            error: (error, stack) {
              // Close loading dialog if exists
              Logger().w("ini adalh indata error $error");
              try {
                if (currentContext.mounted) {
                  Navigator.of(currentContext, rootNavigator: true).pop();
                }
              } catch (e) {
                // No dialog to close or already closed
              }

              // Wait TWO frames before showing snackbar for stable widget tree
              WidgetsBinding.instance.addPostFrameCallback((__) {
                WidgetsBinding.instance.addPostFrameCallback((___) {
                  if (currentContext.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(content: Text(error.toString())),
                    );
                  }
                });
              });
            },
          );
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _deleteUser(String userId, String userName) {
    // Unfocus to avoid focus traversal errors
    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyColor.abuDialog,
        title: Text(
          'Konfirmasi Hapus User',
          style: GoogleFonts.robotoFlex(color: Colors.white),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus user $userName?',
          style: GoogleFonts.robotoFlex(color: Colors.white),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showLoadingDialog('Menghapus user...');
              ref.read(deleteUserProvider.notifier).deleteUser(userId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus',style: GoogleFonts.robotoFlex(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _deleteBatchUsers() {
    if (_idCheck.isEmpty) return;

    // Unfocus to avoid focus traversal errors
    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyColor.abuDialog,
        title: Text(
          'Konfirmasi Hapus Batch User',
          style: GoogleFonts.robotoFlex(color: Colors.white),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus ${_idCheck.length} user?',
          style: GoogleFonts.robotoFlex(color: Colors.white),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final idsToDelete = List<String>.from(_idCheck);
              Navigator.of(context).pop();
              _showLoadingDialog('Menghapus ${idsToDelete.length} user...');
              ref
                  .read(deleteUserProvider.notifier)
                  .deleteBatchUser(idsToDelete);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus',style: GoogleFonts.robotoFlex(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: MyColor.abuDialog,
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.robotoFlex(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userGetListProvider);

    final List<DataRow> datarow = state.userData != null
        ? state.userData!
              .skip(state.currentpage * widget.limit)
              .take(widget.limit)
              .toList()
              .asMap()
              .entries
              .map((values) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        ((state.currentpage * widget.limit) + values.key + 1)
                            .toString(),
                      ),
                    ),
                    DataCell(
                      Checkbox(
                        value: _idCheck.contains(values.value.id),
                        onChanged: (value) {
                          setState(() {
                            if (_idCheck.contains(values.value.id)) {
                              _idCheck = _idCheck
                                  .skip(state.currentpage * widget.limit)
                                  .take(widget.limit)
                                  .where(
                                    (element) => element != values.value.id,
                                  )
                                  .toList();
                            } else {
                              _idCheck = [..._idCheck, values.value.id];
                            }
                          });
                        },
                      ),
                    ),
                    DataCell(
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == AksiNormal.detail) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  DetailUserDialog(idUser: values.value.id),
                            );
                          }
                          if (value == AksiNormal.hapus) {
                            _deleteUser(values.value.id, values.value.name);
                          }
                        },
                        itemBuilder: (BuildContext context) => AksiNormal.values
                            .map(
                              (e) =>
                                  PopupMenuItem(value: e, child: Text(e.teks)),
                            )
                            .toList(),
                      ),
                    ),
                    DataCell(Text(values.value.name)),
                    DataCell(Text(values.value.email)),
                    DataCell(Text(values.value.universityName ?? '')),
                    DataCell(Text(values.value.phoneNumber ?? '')),
                  ],
                );
              })
              .toList()
        : [];
    final List<DataColumn> dataColumnUser = [
      DataColumn(label: Text("No")),
      DataColumn(
        label: Checkbox(
          value: columnIsChecked,
          onChanged: (value) {
            setState(() {
              columnIsChecked = !columnIsChecked;
              if (columnIsChecked == true) {
                _idCheck = [
                  ...state.userData
                          ?.skip(state.currentpage * widget.limit)
                          .take(widget.limit)
                          .map((e) => e.id) ??
                      [],
                ];
              } else {
                _idCheck = [];
              }
            });
          },
        ),
      ),
      DataColumn(label: Text("Aksi")),
      DataColumn(
        label: ColumnSort(
          label: "Nama User",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = SortUser.name;
            });
            ref
                .read(userGetListProvider.notifier)
                .getListUsers(
                  widget.limit,
                  search: searchController.text,
                  sort: isAsc ? Sort.asc : Sort.desc,
                  sortBy: sortBy,
                );
          },
        ),
      ),
      DataColumn(
        label: ColumnSort(
          label: "Email",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = SortUser.email;
            });
            ref
                .read(userGetListProvider.notifier)
                .getListUsers(
                  widget.limit,
                  search: searchController.text,
                  sort: isAsc ? Sort.asc : Sort.desc,
                  sortBy: sortBy,
                );
          },
        ),
      ),
      DataColumn(
        label: ColumnSort(
          label: "Universitas",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = SortUser.university_name;
            });
            ref
                .read(userGetListProvider.notifier)
                .getListUsers(
                  widget.limit,
                  search: searchController.text,
                  sort: isAsc ? Sort.asc : Sort.desc,
                  sortBy: sortBy,
                );
          },
        ),
      ),
      DataColumn(label: Text("No Hp")),
    ];
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedSearcchBar(
                      onSubmitted: (String p1) {
                        ref
                            .read(userGetListProvider.notifier)
                            .getListUsers(
                              widget.limit,
                              search: searchController.text,
                              sort: isAsc ? Sort.asc : Sort.desc,
                              sortBy: sortBy,
                            );
                      },
                      controller: searchController,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .read(userGetListProvider.notifier)
                        .getListUsers(
                          widget.limit,
                          search: searchController.text,
                          sort: isAsc ? Sort.asc : Sort.desc,
                          sortBy: sortBy,
                        );
                  },
                  icon: Icon(Icons.refresh, color: MyColor.hijauaccent),
                  tooltip: 'Refresh',
                ),
                if (_idCheck.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: _deleteBatchUsers,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      icon: Icon(Icons.delete),
                      label: Text(
                        'Hapus (${_idCheck.length})',
                        style: GoogleFonts.robotoFlex(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            Builder(
              builder: (context) {
                if (state.error != null) {
                  return Center(child: Text("Terjadi Kesalahan"));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: state.isloading != true
                      ? TabelContent(
                          dataColumnUser: dataColumnUser,
                          datarow: datarow,
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                );
              },
            ),
            FooterTabel(
              back: state.currentpage > 0
                  ? () {
                      ref.read(userGetListProvider.notifier).back();
                    }
                  : null,
              next:
                  (state.metadata?.totalPages ?? 0) > state.currentpage + 1 &&
                      !(state.isloading ?? true)
                  ? () {
                      ref
                          .read(userGetListProvider.notifier)
                          .appendData(
                            widget.limit,
                            search: searchController.text,
                            sort: isAsc ? Sort.asc : Sort.desc,
                            sortBy: sortBy,
                          );
                    }
                  : null,
              jumlahPage: state.metadata?.totalPages ?? 0,
              currentPage: state.currentpage + 1,
            ),
          ],
        );
      },
    );
  }
}

class DetailUserDialog extends ConsumerStatefulWidget {
  final String idUser;
  const DetailUserDialog({super.key, required this.idUser});

  @override
  ConsumerState<DetailUserDialog> createState() => _DetailUserDialogState();
}

class _DetailUserDialogState extends ConsumerState<DetailUserDialog> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late String _statusValue = Status.aktif.name;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userDetailProvider(widget.idUser));
    final updateState = ref.watch(updateUserProvider);

    return Center(
      child: Card(
        color: MyColor.abuDialog,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 600,
            width: 700,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Edit User",
                          style: GoogleFonts.robotoFlex(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: state.when(
                      data: (data) => _builForm(data, context),
                      error: (error, stackTrace) =>
                          Center(child: Text("Terjadi kesalahan")),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  const Divider(),
                  _buildFooter(context, updateState),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _builForm(DetailUser user, BuildContext context) {
    // Initialize controllers if empty
    if (usernameController.text.isEmpty) {
      usernameController.text = user.username;
      emailController.text = user.email;
      nameController.text = user.name;
      phoneController.text = user.phoneNumber ?? '';
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: MediaQuery.of(context).size.width < 650
          ? SingleChildScrollView(
              child: Column(
                children: [
                  ItemDetailInputOutline(
                    judul: "Username",
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ItemDetailInputOutline(
                    judul: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ItemDetailInputOutline(
                    judul: "Name",
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ItemDetailInputOutline(
                    judul: "Phone",
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 12),
                  ItemDetail(
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
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ItemDetailInputOutline(
                          judul: "Username",
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        ItemDetailInputOutline(
                          judul: "Email",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        ItemDetailInputOutline(
                          judul: "Name",
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ItemDetailInputOutline(
                          judul: "Phone",
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 12),
                        _buildUniversityField(user),
                        SizedBox(height: 12),
                        ItemDetail(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildUniversityField(DetailUser user) {
    return ItemDetailOutline(
      judul: "Universitas",
      sub: ItemDetailText(textSub: user.universityName ?? '-'),
    );
  }

 
  Widget _buildFooter(BuildContext context, AsyncValue<String?> updateState) {
    return updateState.when(
      data: (message) {
        if (message != null) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(updateUserProvider.notifier).reset();
                      ref.invalidate(userDetailProvider(widget.idUser));

                      Navigator.pop(context);
                    },
                    child: Text('Tutup'),
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            SizedBox(width: 12),
            LButtonWeb(
              icon: Icons.save,
              teks: 'Simpan',
              ontap: () async {
                final request = UpdateUserRequest(
                  username: usernameController.text,
                  email: emailController.text,
                  name: nameController.text,
                  phoneNumber: phoneController.text,
                  universityId: "019adf75-15c9-78ee-93d6-370db8303226",
                  isActive: _statusValue == Status.aktif.name,
                );

                await ref
                    .read(updateUserProvider.notifier)
                    .updateUser(widget.idUser, request);
              },
            ),
          ],
        );
      },
      loading: () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text(
              'Menyimpan...',
              style: GoogleFonts.robotoFlex(color: Colors.white),
            ),
          ],
        );
      },
      error: (error, stack) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Error: $error',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(updateUserProvider.notifier).reset();
                  },
                  child: Text('Batal'),
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    final request = UpdateUserRequest(
                      username: usernameController.text,
                      email: emailController.text,
                      name: nameController.text,
                      phoneNumber: phoneController.text,
                      universityId: "019adf75-15c9-78ee-93d6-370db8303226",
                      isActive: _statusValue == Status.aktif.name,
                    );

                    await ref
                        .read(updateUserProvider.notifier)
                        .updateUser(widget.idUser, request);
                  },
                  icon: Icon(Icons.refresh),
                  label: Text('Coba Lagi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
