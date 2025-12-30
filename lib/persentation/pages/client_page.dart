import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/booking_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_detail_booking.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_kirim_wa_client.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_kirim_wa_fotografer.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_tambah_booking.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import '../../../common/color.dart';

class ClientPage extends ConsumerStatefulWidget {
  const ClientPage({super.key});

  @override
  ConsumerState<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends ConsumerState<ClientPage> {
  final searchController = TextEditingController();
  bool isAsc = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
    DataColumn(label: Text('Tanggal')),
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
    
    final bookingState = ref.watch(bookingProvider());
    return bookingState.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (state) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedSearcchBar(
                        controller: searchController,
                        onSubmitted: (value) {
                          ref.invalidate(bookingProvider(search: value.isEmpty ? null : value));
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    LBUttonMobile(
                      icon: Icons.add,
                      teks: 'Tambah Booking',
                      ontap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DialogTambahBooking(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: dataColum,
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
                              PopupMenuButton<AksiBooking>(
                                borderRadius: BorderRadius.circular(14),
                                onSelected: (value) {
                                  if (value == AksiBooking.waclient) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogKirimWAClient(
                                        idBooking: e.value.id,
                                      ),
                                    );
                                  }
                                  if (value == AksiBooking.wafotografer) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogKirimWAFotografer(
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
                                },
                                itemBuilder: (BuildContext context) =>
                                    AksiBooking.values
                                        .map(
                                          (e) => PopupMenuItem(
                                            value: e,
                                            child: Text(e.name),
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
                        ref.read(bookingProvider().notifier).prevPage();
                      }
                    : null,
                next: (state.metadata?.totalPages??0)>state.currentPage+1 && !state.isLoadingMore
                    ? () {
                        ref.read(bookingProvider().notifier).loadMore();
                      }
                    : null,
                currentPage: state.currentPage + 1,
              ),
            ],
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
