import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/common/lottie.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/verify_batch_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/verify_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/state/booking_list_state.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_detail_booking.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_kirim_wa_client.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_kirim_wa_fotografer.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_tambah_booking.dart';
import 'package:wavenadmin/persentation/widget/footer_tabel.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/lottieanimation.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import '../../../common/color.dart';

class ClientPage extends ConsumerStatefulWidget {
  const ClientPage({super.key});

  @override
  ConsumerState<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends ConsumerState<ClientPage> {
  final searchController = TextEditingController();
  late ProviderSubscription _subscription;

  bool isAsc = false;
  SortBooking sortBy = SortBooking.event_date;
  List<String> selectedIds = [];
  bool columnIsChecked = false;

  @override
  void initState() {
    _subscription = ref.listenManual<AsyncValue<BookingListState>>(
      bookingProvider(sortBy: sortBy,
        search: searchController.text,
        sort: isAsc ? Sort.asc : Sort.desc,),
      (
        AsyncValue<BookingListState>? previous,
        AsyncValue<BookingListState> next,
      ) {
        next.whenData((data) {
          if (!context.mounted) return;
          if (data.statusPending != null && data.bookingid != null) {
            if (next.asData?.value.statusPending !=
                previous?.value?.statusPending) {
              showDialogBooking(data.statusPending!);
            }
          }
        });
      },
    );
    super.initState();
  }

  Future<void> showDialogBooking(String statusPending) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyColor.abuDialog,
        icon: switch (statusPending) {
          'succes' => MyLottie(aset: MyLotties.lottieSucces),
          'settlement' => MyLottie(aset: MyLotties.lottieSucces),
          'pending' => MyLottie(aset: MyLotties.lottieWarning),
          _ => MyLottie(aset: MyLotties.lottieCancel),
        },
        title: Text(
          "Status Pembayaran Kamu",
          style: GoogleFonts.robotoFlex(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          statusPending,
          style: GoogleFonts.robotoFlex(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
    if (result == null) {
      ref.read(bookingProvider(sortBy: sortBy,
        search: searchController.text,
        sort: isAsc ? Sort.asc : Sort.desc,).notifier).onResetBookingResult();
    } else {
      ref.read(bookingProvider(sortBy: sortBy,
        search: searchController.text,
        sort: isAsc ? Sort.asc : Sort.desc,).notifier).onResetBookingResult();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _subscription.close();
    super.dispose();
  }

  void _refreshData() {
    setState(() {
      selectedIds.clear();
      columnIsChecked = false;
    });
    ref.invalidate(
      bookingProvider(sortBy: sortBy,
        search: searchController.text,
        sort: isAsc ? Sort.asc : Sort.desc,),
    );
  }

  void _toggleSort(SortBooking newSortBy) {
    setState(() {
      if (sortBy == newSortBy) {
        isAsc = !isAsc;
      } else {
        sortBy = newSortBy;
        isAsc = true;
      }
      selectedIds.clear();
      columnIsChecked = false;
    });
    ref.invalidate(
      bookingProvider(sortBy: sortBy,
        search: searchController.text,
        sort: isAsc ? Sort.asc : Sort.desc,),
    );
  }

  Future<void> _verifyBatch() async {
    if (selectedIds.isEmpty) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyColor.abuDialog,
        title: Text(
          'Konfirmasi Verifikasi Masal',
          style: GoogleFonts.robotoFlex(color: Colors.white),
        ),
        content: Text(
          'Apakah Anda yakin ingin memverifikasi ${selectedIds.length} booking?',
          style: GoogleFonts.robotoFlex(color: Colors.white),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: Text('Batal')),
          ElevatedButton(
            onPressed: () => context.pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColor.hijauaccent,
            ),
            child: Text('Verifikasi'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await ref
        .read(verifyBatchBookingProvider.notifier)
        .verifyBatch(selectedIds);

    final result = ref.read(verifyBatchBookingProvider);
    result.whenData((data) {
      if (data != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${data.verifiedCount} booking berhasil diverifikasi',
            ),
            backgroundColor: MyColor.hijauaccent,
          ),
        );
        _refreshData();
      }
    });
  }

  Color _getStatusColor(String status, bool isVerification) {
    if (isVerification) {
      switch (status) {
        case 'APPROVED':
          return MyColor.hijauaccent;
        case 'REJECTED':
          return Colors.red;
        case 'PENDING':
        default:
          return MyColor.oren;
      }
    } else {
      // Booking status
      switch (status) {
        case 'LUNAS':
          return MyColor.hijauaccent;
        case 'DP':
          return MyColor.birutua;
        case 'CANCELLED':
          return Colors.red;
        case 'PENDING':
        default:
          return MyColor.kuning;
      }
    }
  }

  List<DataColumn> dataColum = [
    DataColumn(label: Text('No')),
    DataColumn(label: Text('Aksi')),
    DataColumn(label: Text('Nama Client')),
    DataColumn(label: Text('Universitas')),
    DataColumn(label: Text('No HP')),
    DataColumn(label: Text('Package')),
    DataColumn(
      label: ColumnSort(label: "Tanggal", onTap: () {}),
    ),
    DataColumn(label: Text('Waktu')),
    DataColumn(label: Text('Sudah Bayar')),
    DataColumn(label: Text('Status Bayar')),
    DataColumn(label: Text('Verifikasi')),
    DataColumn(label: Text('Status Foto')),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 700;
    final isVerySmallScreen = width < 300;

    final bookingState = ref.watch(
      bookingProvider(
        sortBy: sortBy,
        search: searchController.text,
        sort: isAsc ? Sort.asc : Sort.desc,
      ),
    );
    return bookingState.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Column(
        children: [
          Text('Error: $error'),
          MButtonWeb(
            ontap: () {
              ref.invalidate(
                bookingProvider(
                  sortBy: sortBy,
                  search: searchController.text,
                  sort: isAsc ? Sort.asc : Sort.desc,
                ),
              );
            },
            teks: "Coba Lagi",
          ),
        ],
      ),
      data: (state) {
        // Update selectedIds if needed (remove ids that are no longer in the list)
        final currentPageBookings = state.items
            .skip(state.currentPage * BookingNotifier.limit)
            .take(BookingNotifier.limit)
            .toList();
        final currentBookingIds = currentPageBookings.map((b) => b.id).toSet();
        selectedIds.removeWhere((id) => !currentBookingIds.contains(id));

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HeaderPage(judul: "Client", icon: MyIcon.iconmanajemenclien),
                isVerySmallScreen
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.iconusers,
                                  judul: "Total Bookings",
                                  content: state.totalBooking.toString(),
                                  color: MyColor.oren,
                                  subcontent: "Clients",
                                ),
                              ),
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.icondompet,
                                  judul: "Belum Lunas",
                                  content: state.totalPending.toString(),
                                  color: MyColor.birutua,
                                  subcontent: "Clients",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.icondompet,
                                  judul: "Lunas",
                                  content: state.totalLunas.toString(),
                                  color: MyColor.hijauaccent,
                                  subcontent: "Clients",
                                ),
                              ),
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.iconcancel,
                                  judul: "Perlu Verifikasi",
                                  content: state.totalNeedVerified.toString(),
                                  color: MyColor.oren,
                                  subcontent: "Clients",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.iconcheck,
                                  judul: "Terverifikasi",
                                  content: state.totalVerified.toString(),
                                  color: MyColor.hijauaccent,
                                  subcontent: "Clients",
                                ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      )
                    : isSmallScreen
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.iconusers,
                                  judul: "Total Bookings",
                                  content: state.totalBooking.toString(),
                                  color: MyColor.oren,
                                  subcontent: "Clients",
                                ),
                              ),
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.icondompet,
                                  judul: "Belum Lunas",
                                  content: state.totalPending.toString(),
                                  color: MyColor.birutua,
                                  subcontent: "Clients",
                                ),
                              ),
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.icondompet,
                                  judul: "Lunas",
                                  content: state.totalLunas.toString(),
                                  color: MyColor.hijauaccent,
                                  subcontent: "Clients",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.iconcancel,
                                  judul: "Perlu Verifikasi",
                                  content: state.totalNeedVerified.toString(),
                                  color: MyColor.oren,
                                  subcontent: "Clients",
                                ),
                              ),
                              Expanded(
                                child: CardItemContainer(
                                  aset: MyIcon.iconcheck,
                                  judul: "Terverifikasi",
                                  content: state.totalVerified.toString(),
                                  color: MyColor.hijauaccent,
                                  subcontent: "Clients",
                                ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: CardItemContainer(
                              aset: MyIcon.iconusers,
                              judul: "Total Bookings",
                              content: state.totalBooking.toString(),
                              color: MyColor.oren,
                              subcontent: "Clients",
                            ),
                          ),
                          Expanded(
                            child: CardItemContainer(
                              aset: MyIcon.icondompet,
                              judul: "Belum Lunas",
                              content: state.totalPending.toString(),
                              color: MyColor.birutua,
                              subcontent: "Clients",
                            ),
                          ),
                          Expanded(
                            child: CardItemContainer(
                              aset: MyIcon.icondompet,
                              judul: "Lunas",
                              content: state.totalLunas.toString(),
                              color: MyColor.hijauaccent,
                              subcontent: "Clients",
                            ),
                          ),
                          Expanded(
                            child: CardItemContainer(
                              aset: MyIcon.iconcancel,
                              judul: "Perlu Verifikasi",
                              content: state.totalNeedVerified.toString(),
                              color: MyColor.oren,
                              subcontent: "Clients",
                            ),
                          ),
                          Expanded(
                            child: CardItemContainer(
                              aset: MyIcon.iconcheck,
                              judul: "Terverifikasi",
                              content: state.totalVerified.toString(),
                              color: MyColor.hijauaccent,
                              subcontent: "Clients",
                            ),
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedSearcchBar(
                          controller: searchController,
                          onSubmitted: (value) {
                            setState(() {
                              selectedIds.clear();
                              columnIsChecked = false;
                            });
                            ref.invalidate(
                              bookingProvider(
                                search: searchController.text,
                                sortBy: sortBy,
                                sort: isAsc ? Sort.asc : Sort.desc,
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: _refreshData,
                                icon: Icon(
                                  Icons.refresh,
                                  color: MyColor.hijauaccent,
                                ),
                                tooltip: 'Refresh',
                              ),
                              if (selectedIds.isNotEmpty)
                                LBUttonMobile(
                                  ontap: _verifyBatch,
                                  teks: "Verifikasi (${selectedIds.length})",
                                ),
                              LBUttonMobile(
                                icon: Icons.add,
                                teks: 'Tambah Booking',
                                ontap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => DialogTambahBooking(),
                                  );
                                  _refreshData();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(
                        label: Checkbox(
                          value: columnIsChecked,
                          onChanged: (value) {
                            setState(() {
                              columnIsChecked = value ?? false;
                              if (columnIsChecked) {
                                final currentPageBookings = state.items
                                    .skip(
                                      state.currentPage * BookingNotifier.limit,
                                    )
                                    .take(BookingNotifier.limit)
                                    .toList();
                                selectedIds = currentPageBookings
                                    .map((b) => b.id)
                                    .toList();
                              } else {
                                selectedIds.clear();
                              }
                            });
                          },
                        ),
                      ),
                      DataColumn(label: Text('Aksi')),
                      DataColumn(
                        label: Text("Nama Client")
                      ),
                      DataColumn(
                        label: Text("Universitas")
                      ),
                      DataColumn(label: Text('No HP')),
                      DataColumn(
                        label: Text("Package")
                      ),
                      DataColumn(
                        label: ColumnSort(
                          label: "Tanggal",
                          onTap: () => _toggleSort(SortBooking.event_date),
                        ),
                      ),
                      DataColumn(label: Text('Waktu')),
                      DataColumn(label: Text('Sudah Bayar')),
                      DataColumn(
                        label: ColumnSort(
                          label: "Status Bayar",
                          onTap: () => _toggleSort(SortBooking.status),
                        ),
                      ),
                      DataColumn(
                        label: Text("Verifikasi")
                      ),
                      DataColumn(
                        label: ColumnSort(
                          label: "Status Foto",
                          onTap: () => _toggleSort(SortBooking.already_photo),
                        ),
                      ),
                    ],
                    rows: state.items
                        .skip(state.currentPage * BookingNotifier.limit)
                        .take(BookingNotifier.limit)
                        .toList()
                        .asMap()
                        .entries
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  ((state.currentPage * BookingNotifier.limit) +
                                          e.key +
                                          1)
                                      .toString(),
                                ),
                              ),
                              DataCell(
                                Checkbox(
                                  value: selectedIds.contains(e.value.id),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedIds.add(e.value.id);
                                      } else {
                                        selectedIds.remove(e.value.id);
                                      }
                                      final currentPageBookings = state.items
                                          .skip(
                                            state.currentPage *
                                                BookingNotifier.limit,
                                          )
                                          .take(BookingNotifier.limit)
                                          .toList();
                                      columnIsChecked =
                                          selectedIds.length ==
                                          currentPageBookings.length;
                                    });
                                  },
                                ),
                              ),
                              DataCell(
                                PopupMenuButton<AksiBooking>(
                                  borderRadius: BorderRadius.circular(14),
                                  onSelected: (value) {
                                    if (value == AksiBooking.waclient) {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DialogKirimWAClient(
                                              idBooking: e.value.id,
                                            ),
                                      );
                                    }
                                    if (value == AksiBooking.wafotografer) {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DialogKirimWAFotografer(
                                              idBooking: e.value.id,
                                            ),
                                      );
                                    }
                                    if (value == AksiBooking.detail) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Center(
                                          child: DialogDetailBooking(
                                            idBooking: e.value.id,
                                          ),
                                        ),
                                      );
                                    }
                                    if (value == AksiBooking.verifikasi) {
                                      ref
                                          .read(verifyBookingProvider.notifier)
                                          .execute(
                                            e.value.id,
                                            VerifyStatus.approved,
                                          );
                                      Future.delayed(
                                        Duration(seconds: 1),
                                        () => _refreshData(),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      AksiBooking.values
                                          .map(
                                            (e) => PopupMenuItem(
                                              value: e,
                                              child: Text(e.teks),
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                              DataCell(Text(e.value.clientName)),
                              DataCell(Text(e.value.universityName)),
                              DataCell(Text(e.value.phoneNumber)),
                              DataCell(Text(e.value.packageName)),
                              DataCell(Text(e.value.eventDate)),
                              DataCell(
                                Text(
                                  '${e.value.eventStartTime}-${e.value.eventEndTime}',
                                ),
                              ),
                              DataCell(Text('Rp ${e.value.paidAmount}')),
                              DataCell(
                                _buildStatusChip(
                                  e.value.status,
                                  color: _getStatusColor(e.value.status, false),
                                ),
                              ),
                              DataCell(
                                _buildStatusChip(
                                  e.value.verificationStatus,
                                  color: _getStatusColor(
                                    e.value.verificationStatus,
                                    true,
                                  ),
                                ),
                              ),
                              DataCell(
                                _buildStatusChip(
                                  e.value.alreadyPhoto
                                      ? 'Sudah Foto'
                                      : 'Belum Foto',
                                  color: e.value.alreadyPhoto
                                      ? MyColor.hijauaccent
                                      : MyColor.oren,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                FooterTabel(
                  jumlahPage: state.metadata?.totalPages ?? 0,
                  back: state.currentPage > 0
                      ? () {
                          ref
                              .read(
                                bookingProvider(
                                  sortBy: sortBy,
                                  sort: isAsc ? Sort.asc : Sort.desc,
                                  search: searchController.text,
                                ).notifier,
                              )
                              .prevPage();
                          setState(() {
                            selectedIds.clear();
                            columnIsChecked = false;
                          });
                        }
                      : null,
                  next:
                      (state.metadata?.totalPages ?? 0) >
                              state.currentPage + 1 &&
                          !state.isLoadingMore
                      ? () {
                          ref
                              .read(
                                bookingProvider(
                                  sortBy: sortBy,
                                  sort: isAsc ? Sort.asc : Sort.desc,
                                  search: searchController.text,
                                ).notifier,
                              )
                              .loadMore(
                                sortBy: sortBy,
                                search: searchController.text,
                                sort: isAsc ? Sort.asc : Sort.desc,
                              );
                          setState(() {
                            selectedIds.clear();
                            columnIsChecked = false;
                          });
                        }
                      : null,
                  currentPage: state.currentPage + 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String label, {required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
