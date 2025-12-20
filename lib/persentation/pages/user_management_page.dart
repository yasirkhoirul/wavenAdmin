import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/detailUser.dart';
import 'package:wavenadmin/persentation/pages/photo_grapher_management_page.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/userDetail.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/user_list_notifier.dart';
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
  int limit = 3;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userGetListProvider.notifier).getListUsers(limit);
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
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 400,
                        minWidth: 200
                      ) ,
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
    ref.listenManual(userGetListProvider, (previous, next) {
      if (previous?.userData != next.userData) {
        setState(() {
          columnIsChecked = false;
          _idCheck = [];
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger().d(_idCheck);
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
      DataColumn(label: ColumnSort(label: "Nama User", onTap: (){
        setState(() {
          isAsc = !isAsc;
          sortBy = SortUser.name;
        });
        ref.read(userGetListProvider.notifier).getListUsers(widget.limit,search: searchController.text,sort: isAsc?Sort.asc:Sort.desc,sortBy: sortBy);
      })),
      DataColumn(label: ColumnSort(label: "Email", onTap: () {
        setState(() {
          isAsc = !isAsc;
          sortBy = SortUser.email;
        });
        ref.read(userGetListProvider.notifier).getListUsers(widget.limit,search: searchController.text,sort: isAsc?Sort.asc:Sort.desc,sortBy: sortBy);
      },)),
      DataColumn(label: ColumnSort(label: "Universitas", onTap: (){
        setState(() {
          isAsc = !isAsc;
          sortBy = SortUser.university_name;
        });
        ref.read(userGetListProvider.notifier).getListUsers(widget.limit,search: searchController.text,sort: isAsc?Sort.asc:Sort.desc,sortBy: sortBy);
      })),
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedSearcchBar(
                      onSubmitted: (String p1) {
                        ref.read(userGetListProvider.notifier).getListUsers(widget.limit,search: p1);
                      },
                      controller: searchController,
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
            FooterTabel(
              back: state.currentpage > 0
                  ? () {
                      ref.read(userGetListProvider.notifier).back();
                    }
                  : null,
              next: (state.metadata?.totalPages??0) > state.currentpage + 1 && !(state.isloading??true)
                  ? () {
                    
                    ref.read(userGetListProvider.notifier).appendData(widget.limit,search: searchController.text,sort: isAsc?Sort.asc:Sort.desc,sortBy: sortBy);
                  }
                  : null,
              jumlahPage: state.metadata?.totalPages??0,
              currentPage: state.currentpage+1,
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
