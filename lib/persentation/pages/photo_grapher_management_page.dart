import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/domain/entity/detail_fotografer.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/fotografer_detail.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/fotografer_mutation.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/photographer_list.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class PhotoGrapherManagementPage extends ConsumerStatefulWidget {
  const PhotoGrapherManagementPage({super.key});

  @override
  ConsumerState<PhotoGrapherManagementPage> createState() =>
      _PhotoGrapherManagementPageState();
}

class _PhotoGrapherManagementPageState
    extends ConsumerState<PhotoGrapherManagementPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(photographerListProvider.notifier).loadFirstPage(sort: Sort.asc);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1000,
        child: Column(
          children: [
            Row(
              children: [
                HeaderPage(icon: MyIcon.iconusers, judul: "Photographer"),
              ],
            ),
            Expanded(child: TabelPhotographer()),
          ],
        ),
      ),
    );
  }
}

class TabelPhotographer extends ConsumerStatefulWidget {
  const TabelPhotographer({super.key});

  @override
  ConsumerState<TabelPhotographer> createState() => _TabelPhotographerState();
}

class _TabelPhotographerState extends ConsumerState<TabelPhotographer> {
  final searchcontroller = TextEditingController();
  bool isAsc = true;
  SortPhotographer? sortBy;

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(photographerListProvider);
    Logger().d(
      "ini adalah current page,${state.currentPage} dan ini high ${state.highestPage}",
    );
    final dataColum = [
      const DataColumn(label: Text("No")),
      const DataColumn(label: Text("Aksi")),
      DataColumn(
        label: ColumnSort(
          label: "Nama Fotografer",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = SortPhotographer.name;
            });
            ref.read(photographerListProvider.notifier).loadFirstPage(
              search: searchcontroller.text,
              sort: isAsc ? Sort.asc : Sort.desc,
              sortBy: sortBy,
            );
          },
        ),
      ),
      const DataColumn(label: Text("No Hp")),
      const DataColumn(label: Text("Instagram")),
      DataColumn(
        label: ColumnSort(
          label: "Lokasi",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = SortPhotographer.location;
            });
            ref.read(photographerListProvider.notifier).loadFirstPage(
              search: searchcontroller.text,
              sort: isAsc ? Sort.asc : Sort.desc,
              sortBy: sortBy,
            );
          },
        ),
      ),
      const DataColumn(label: Text("Gear")),
      DataColumn(
        label: ColumnSort(
          label: "Fee Per Jam",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = SortPhotographer.fee_per_hour;
            });
            ref.read(photographerListProvider.notifier).loadFirstPage(
              search: searchcontroller.text,
              sort: isAsc ? Sort.asc : Sort.desc,
              sortBy: sortBy,
            );
          },
        ),
      ),
      DataColumn(
        label: ColumnSort(
          label: "Rekening",
          onTap: () {
            setState(() {
              isAsc = !isAsc;
              sortBy = SortPhotographer.bank_account;
            });
            ref.read(photographerListProvider.notifier).loadFirstPage(
              search: searchcontroller.text,
              sort: isAsc ? Sort.asc : Sort.desc,
              sortBy: sortBy,
            );
          },
        ),
      ),
      const DataColumn(label: Text("No Rekening")),
    ];
    final datRow = state.items
        .skip(state.currentPage * PhotographerList.limit)
        .take(PhotographerList.limit)
        .toList()
        .asMap()
        .entries
        .map(
          (e) => DataRow(
            cells: [
              DataCell(
                Text(
                  ((state.currentPage * PhotographerList.limit) + e.key + 1)
                      .toString(),
                ),
              ),
              DataCell(
                PopupMenuButton(
                  onSelected: (value) => showDialog(
                    context: context,
                    builder: (context) => value == "Edit"
                        ? DialogDetailFotografer(idFotografer: e.value.id)
                        : DialogDeleteFotografer(idFotografer: e.value.id),
                  ),
                  itemBuilder: (context) => ['Edit', "Hapus"]
                      .map((e) => PopupMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              ),
              DataCell(Text(e.value.name)),
              DataCell(Text(e.value.phoneNumber ?? '')),
              DataCell(Text(e.value.instagram ?? '')),
              DataCell(Text(e.value.location ?? '')),
              DataCell(Text(e.value.gears ?? '')),
              DataCell(Text(e.value.feePerHour.toString())),
              DataCell(Text(e.value.bankAccount ?? '')),
              DataCell(Text(e.value.accountNumber ?? '')),
            ],
          ),
        )
        .toList();
    return Column(
      spacing: 10,
      children: [
        
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OutlinedSearcchBar(
              onSubmitted: (String p1) {
                ref
                    .read(photographerListProvider.notifier)
                    .loadFirstPage(search: p1);
              },
              controller: searchcontroller,
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: state.isLoading != true && state.isLoadingMore != true
              ? TabelContent(dataColumnUser: dataColum, datarow: datRow)
              : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(child: CircularProgressIndicator()),
                ),
        ),
        FooterTabel(
          jumlahPage: state.metadata?.totalPages ?? 0,
          back: state.currentPage > 0
              ? () {
                  ref.read(photographerListProvider.notifier).prevPage();
                }
              : null,
          next:
              (state.isLoading ||
                  state.isLoadingMore ||
                  (state.currentPage + 1 == state.metadata?.totalPages))
              ? null
              : () {
                  ref
                      .read(photographerListProvider.notifier)
                      .loadMore(
                        search: searchcontroller.text,
                        sort: isAsc ? Sort.asc : Sort.desc,
                        sortBy: sortBy,
                      );
                },
          currentPage: state.currentPage + 1,
        ),
      ],
    );
  }
}

class DialogDeleteFotografer extends ConsumerWidget {
  final String idFotografer;
  const DialogDeleteFotografer({super.key, required this.idFotografer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fotograferMutationProvider(idFotografer));
    return state.when(
      data: (data) {
        final bool isNull = data == null;
        return AlertDialog(
          backgroundColor: MyColor.abuDialog,
          content: isNull ? Text("Anda yakin ingin menghapus?") : Text(data),
          actions: isNull
              ? <Widget>[
                  MButtonWeb(
                    ontap: () async{
                      await ref.read(fotograferMutationProvider(idFotografer).notifier).deleteFotografer();
                    },
                    teks: "Ok",
                  ),
                ]
              : [],
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return AlertDialog(content: Text(error.toString()));
      },
      loading: () {
        return AlertDialog(content: SizedBox(
          height: 50,
          width: 50,
          child: Center(child: CircularProgressIndicator())));
      },
    );
  }
}

class DialogDetailFotografer extends ConsumerStatefulWidget {
  final String idFotografer;
  const DialogDetailFotografer({super.key, required this.idFotografer});

  @override
  ConsumerState<DialogDetailFotografer> createState() =>
      _DialogDetailFotograferState();
}

class _DialogDetailFotograferState
    extends ConsumerState<DialogDetailFotografer> {
  final TextEditingController nama = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController instagram = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController gear = TextEditingController();
  final TextEditingController fee = TextEditingController();
  final TextEditingController rekening = TextEditingController();
  final TextEditingController namabank = TextEditingController();

  bool _didInitController = false;
  bool _isActive = false;
  ProviderSubscription<AsyncValue<DetailFotografer>>? _detailSub;
  ProviderSubscription<AsyncValue<String?>>? _mutationSub;

  @override
  void initState() {
    super.initState();
    _detailSub = ref.listenManual<AsyncValue<DetailFotografer>>(
      fotograferDetailProvider(widget.idFotografer),
      (prev, next) {
        next.whenOrNull(
          data: (data) {
            if (_didInitController) return;
            _didInitController = true;

            nama.text = data.name;
            email.text = data.email;
            phone.text = data.phoneNumber ?? '';
            instagram.text = '';
            rekening.text = data.accountNumber ?? '';
            namabank.text = data.bankAccount ?? '';
            location.text = '';
            
            gear.text = data.gear ?? '';
            fee.text = data.feePerHour?.toString() ?? '';
            _isActive = data.isActive;
          },
          error: (err, _) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Gagal load detail: $err')));
          },
        );
      },
      fireImmediately: true,
    );

    _mutationSub = ref.listenManual<AsyncValue<String?>>(
      fotograferMutationProvider(widget.idFotografer),
      (prev, next) {
        next.whenOrNull(
          data: (message) {
            if (message == null) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
            ref
                .read(fotograferMutationProvider(widget.idFotografer).notifier)
                .reset();
          },
          error: (err, _) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Gagal update: $err')));
            ref
                .read(fotograferMutationProvider(widget.idFotografer).notifier)
                .reset();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _detailSub?.close();
    _mutationSub?.close();
    nama.dispose();
    email.dispose();
    phone.dispose();
    instagram.dispose();
    location.dispose();
    gear.dispose();
    fee.dispose();
    rekening.dispose();
    namabank.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailFotografer = ref.watch(
      fotograferDetailProvider(widget.idFotografer),
    );
    final mutattionFotografer = ref.watch(
      fotograferMutationProvider(widget.idFotografer),
    );
    return Center(
      child: Card(
        color: MyColor.abuDialog,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 500, maxWidth: 700),
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
                      "Fotografer Detail",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  detailFotografer.when(
                    data: (data) {
                      return _builForm(
                        data,
                        context,
                        [
                          ItemDetailInputOutline(
                            judul: "Nama",
                            controller: nama,
                          ),
                          ItemDetailInputOutline(
                            judul: "Email",
                            controller: email,
                          ),
                          ItemDetailInputOutline(
                            judul: "No Hp",
                            controller: phone,
                            keyboardType: TextInputType.phone,
                          ),
                          ItemDetailInputOutline(
                            judul: "Instagram",
                            controller: instagram,
                          ),
                          ItemDetailInputOutline(
                            judul: "Lokasi Base",
                            controller: location,
                          ),
                        ],
                        [
                          ItemDetailInputOutline(
                            judul: "Gear",
                            controller: gear,
                          ),
                          ItemDetailInputOutline(judul: "Fee", controller: fee),
                          ItemDetailInputOutline(
                            judul: "Bank Rekening",
                            controller: namabank,
                          ),
                          ItemDetailInputOutline(
                            judul: "No Rekening",
                            controller: rekening,
                            keyboardType: TextInputType.number,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status Aktif",
                                  style: GoogleFonts.robotoFlex(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Switch(
                                  value: _isActive,
                                  onChanged: (value) {
                                    setState(() {
                                      _isActive = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text("Terjadi kesalahan")),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                  const Divider(),
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: mutattionFotografer.when(
                            data: (data) => MButtonWeb(
                              ontap: () async {
                                final isSaving = ref
                                    .read(
                                      fotograferMutationProvider(
                                        widget.idFotografer,
                                      ),
                                    )
                                    .isLoading;
                                if (isSaving) return;

                                final current = ref
                                    .read(
                                      fotograferDetailProvider(
                                        widget.idFotografer,
                                      ),
                                    )
                                    .asData
                                    ?.value;
                                if (current == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Data belum siap.'),
                                    ),
                                  );
                                  return;
                                }

                                final parsedFee = int.tryParse(fee.text.trim());
                                if (parsedFee == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Fee tidak valid.'),
                                    ),
                                  );
                                  return;
                                }

                                String? normalize(String value) {
                                  final trimmed = value.trim();
                                  return trimmed.isEmpty ? null : trimmed;
                                }

                                // Update via mutation provider; UI handles success/error via listen.
                                ref
                                    .read(
                                      fotograferMutationProvider(
                                        widget.idFotografer,
                                      ).notifier,
                                    )
                                    .submitUpdate(
                                      DetailFotografer(
                                        current.id,
                                        current.username,
                                        normalize(email.text) ?? current.email,
                                        normalize(nama.text) ?? current.name,
                                        normalize(phone.text),
                                        normalize(rekening.text),
                                        normalize(namabank.text),
                                        _isActive,
                                        normalize(gear.text),
                                        parsedFee,
                                        current.createdAt,
                                      ),
                                    );
                              },
                              teks: "Simpan",
                              icon: Icons.save_alt,
                            ),
                            loading: () => CircularProgressIndicator(),
                            error: (error, stackTrace) => IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.restart_alt),
                            ),
                          ),
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

Widget _builForm(
  DetailFotografer user,
  BuildContext context,
  List<Widget> kiri,
  List<Widget> kanan,
) {
  return LayoutBuilder(
    builder: (context, constrains) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: MediaQuery.of(context).size.width < 650
            ? Column(children: [...kiri, ...kanan])
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Expanded(
                    child: SizedBox(child: Column(children: kiri)),
                  ),
                  Expanded(child: Column(children: kanan)),
                ],
              ),
      );
    },
  );
}

class FooterTabel extends StatelessWidget {
  final int? jumlahPage;
  final Function()? back;
  final Function()? next;
  final int currentPage;
  const FooterTabel({
    super.key,
    required this.back,
    required this.next,
    required this.jumlahPage,
    required this.currentPage,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = [
      Expanded(child: Text("Jumlah Page ${jumlahPage ?? 0}",style: GoogleFonts.robotoFlex(
            fontWeight: FontWeight.bold
          ),)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          MediaQuery.of(context).size.width > 900?MButtonWeb(ontap: back, teks: "Kembali"):MButtonMobile(ontap: back, teks: "Kembali"),
          Text("$currentPage",style: GoogleFonts.robotoFlex(
            fontWeight: FontWeight.bold
          ),),
           MediaQuery.of(context).size.width > 900?MButtonWeb(ontap: next, teks: "Berikutnya"):MButtonMobile(ontap: next, teks: "Berikutnya"),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: MediaQuery.of(context).size.width > 900
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: dataList,
            )
          : ConstrainedBox(
              constraints: BoxConstraints(minHeight: 50, maxHeight: 70),
              child: Column(children: dataList),
            ),
    );
  }
}

class ColumnSort extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ColumnSort({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        InkWell(
          onTap: onTap,
          child: Icon(Icons.sort),
        ),
      ],
    );
  }
}
