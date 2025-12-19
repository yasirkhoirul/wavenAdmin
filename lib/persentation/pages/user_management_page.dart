import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/detailUser.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/userDetail.dart';
import 'package:wavenadmin/persentation/riverpod/provider/user_list_provider.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class UserManagementpage extends ConsumerStatefulWidget {
  const UserManagementpage({super.key});

  @override
  ConsumerState<UserManagementpage> createState() => _UserManagementpageState();
}

class _UserManagementpageState extends ConsumerState<UserManagementpage> {
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(userGetListProvider.notifier)
          .getListUsers(0 + 1, 3);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userGetListProvider);
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Column(
            children: [
              Row(
                children: [HeaderPage(icon: MyIcon.iconusers, judul: "User")],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 400,
                    child: CardItemContainer(
                      aset: MyIcon.iconusers,
                      judul: "Total Users",
                      content: state.totaldata == null?"Loading":state.totaldata.toString(),
                      color: MyColor.oren,
                    ),
                  ),
                ],
              ),
              Expanded(child: TabelUser()),
            ],
          ),
        ),
      ),
    );
  }
}

class TabelUser extends ConsumerStatefulWidget {
  const TabelUser({super.key});

  @override
  ConsumerState<TabelUser> createState() => _TabelUserState();
}

class _TabelUserState extends ConsumerState<TabelUser> {
  bool columnIsChecked = false;
  List<String> _idCheck = [];
  int limit = 3;
  int page = 0;
  int heighestPage = 0;
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userGetListProvider);

    final List<DataRow> datarow = state.userData != null
        ? state.userData!
              .skip(page * limit)
              .take(limit)
              .toList()
              .asMap()
              .entries
              .map((values) {
                return DataRow(
                  cells: [
						DataCell(
							Text(((page * limit) + values.key + 1).toString()),
						),
                    DataCell(
                      Checkbox(
                        value: _idCheck.contains(values.value.id),
                        onChanged: (value) {
                          setState(() {
                            if (_idCheck.contains(values.value.id)) {
                              _idCheck = _idCheck
                                  .skip(page * limit)
                                  .take(limit)
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
                          if (value == AksiBooking.detail) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  DetailUserDialog(idUser: values.value.id),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => AksiBooking
                            .values
                            .map(
                              (e) =>
                                  PopupMenuItem(value: e, child: Text(e.name)),
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
    final int count = datarow.length;
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
                          ?.skip(page * limit)
                          .take(limit)
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
      DataColumn(label: Text("Nama User")),
      DataColumn(label: Text("Email")),
      DataColumn(label: Text("Universitas")),
      DataColumn(label: Text("No Hp")),
    ];
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedSearcchBar(onSubmitted: (String p1) {}),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state.isloading != true
                        ? TabelContent(
                            dataColumnUser: dataColumnUser,
                            datarow: datarow,
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                );
              },
            ),
            Row(
              children: [
                IconButton(
                  onPressed: page > 0
                      ? () {
                          if (page > 0) {
                            setState(() {
                              _idCheck = [];
                              columnIsChecked = false;
                              page--;
                            });
                          }
                          Logger().d("heghest page $heighestPage, page $page");
                        }
                      : null,
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: count == limit
                      ? () {
                          if (limit == count) {
                            setState(() {
                              columnIsChecked = false;
                              _idCheck = [];
                              if (heighestPage == page) {
                                heighestPage++;
                                ref
                                    .read(userGetListProvider.notifier)
                                    .appendData(heighestPage + 1, limit);
                              }
                              page++;
                            });
                          }
                        }
                      : null,
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class DetailUserDialog extends ConsumerWidget {
  final String idUser;
  const DetailUserDialog({super.key, required this.idUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userDetailProvider(idUser));
    return Center(
      child: Card(
        color: MyColor.abuDialog,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 500,
            width: 700,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "User Detail",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _builForm(DetailUser user, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: MediaQuery.of(context).size.width < 650
          ? Column(
              children: [
                ItemDetailOutline(judul: "Username", sub: Text(user.username)),
                ItemDetailOutline(judul: "Email", sub: Text(user.email)),
                ItemDetailOutline(judul: "Name", sub: Text(user.name)),
                ItemDetailOutline(
                  judul: "Phone",
                  sub: Text(user.phoneNumber ?? ''),
                ),
                ItemDetailOutline(
                  judul: "Universitas",
                  sub: Text(user.universityName ?? ''),
                ),
              ],
            )
          : Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ItemDetailOutline(
                        judul: "Username",
                        sub: Text(user.username),
                      ),
                      ItemDetailOutline(judul: "Email", sub: Text(user.email)),
                      ItemDetailOutline(judul: "Name", sub: Text(user.name)),
                      ItemDetailOutline(
                        judul: "Phone",
                        sub: Text(user.phoneNumber ?? ''),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ItemDetailOutline(
                        judul: "Universitas",
                        sub: Text(user.universityName ?? ''),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
