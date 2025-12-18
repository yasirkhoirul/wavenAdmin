import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/riverpod/provider/user_list_provider.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
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
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                      content: "100",
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userGetListProvider.notifier).getListUsers(heighestPage+1, limit);
    },);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userGetListProvider);
    
    final List<DataRow> datarow = state.userData != null? state.userData!.skip(page * limit).take(limit).map((
      values,
    ) {
      return DataRow(
        cells: [
          DataCell(Text(values.id.toString())),
          DataCell(
            Checkbox(
              value: _idCheck.contains(values.id),
              onChanged: (value) {
                setState(() {
                  if (_idCheck.contains(values.id)) {
                    _idCheck = _idCheck.skip(page*limit).take(limit)
                        .where((element) => element != values.id)
                        .toList();
                  } else {
                    _idCheck = [..._idCheck, values.id];
                  }
                });
              },
            ),
          ),
          DataCell(
            PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) => AksiBooking.values.map((e) => PopupMenuItem(value: e, child: Text(e.name))).toList(),
            ),
          ),
          DataCell(Text(values.name)),
          DataCell(Text(values.email)),
          DataCell(Text(values.universityName??'')),
          DataCell(Text(values.phoneNumber??'')),
        ],
      );
    }).toList():[];
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
                _idCheck = [...state.userData?.skip(page*limit).take(limit).map((e) => e.id)??[]];
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
                  child: OutlinedSearcchBar(onSubmitted: (String p1) {  },),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                if (state.error != null) {
                  return Center(child: Text("Terjadi Kesalahan"),);
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state.isloading != true? TabelContent(dataColumnUser: dataColumnUser, datarow: datarow,):Center(child: CircularProgressIndicator(),),
                  ),
                );
              }
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
                              if (heighestPage==page) {
                                heighestPage++;
                                ref.read(userGetListProvider.notifier).appendData(heighestPage+1, limit);
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



