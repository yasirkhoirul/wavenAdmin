import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/pages/fotografer_detail_page.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/photographer_payment_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_payment_state.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class FotograferReferencePage extends ConsumerStatefulWidget {
  const FotograferReferencePage({super.key});

  @override
  ConsumerState<FotograferReferencePage> createState() =>
      _FotograferReferencePageState();
}

class _FotograferReferencePageState
    extends ConsumerState<FotograferReferencePage> {
  final TextEditingController searchController = TextEditingController();
  int limit = 10;
  bool isAsc = true;
  SortPhotographerPayment? sortBy;
  String searchQuery = '';
  DateTime? startTime;
  DateTime? endTime;

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      photographerPaymentProvider(
        0,
        limit,
        search: searchQuery,
        startTime: startTime,
        endTime: endTime,
        sortBy: sortBy,
        sort: isAsc ? Sort.asc : Sort.desc,
      ),
    );

    return SingleChildScrollView(
      child: SizedBox(
        height: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderPage(
              judul: "Photographer Payment",
              icon: MyIcon.iconusers,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: OutlinedSearcchBar(
                          onSubmitted: (value) {
                            Logger().d("Search: $value");
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          controller: searchController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildDateInput(
                        label: "Start Date",
                        date: startTime,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: startTime ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              startTime = picked;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 16),
                      _buildDateInput(
                        label: "End Date",
                        date: endTime,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: endTime ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              endTime = picked;
                            });
                          }
                        },
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 20),
                  state.requestState == RequestState.loading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8127,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : state.requestState == RequestState.error
                          ? Center(
                              child: Column(
                                children: [
                                  Text('Error: ${state.message}'),
                                  ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                            photographerPaymentProvider(
                                              0,
                                              limit,
                                              search: searchQuery,
                                              startTime: startTime,
                                              endTime: endTime,
                                              sortBy: sortBy,
                                              sort: isAsc ? Sort.asc : Sort.desc,
                                            ).notifier,
                                          )
                                          .refresh();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            )
                          : _buildTable(context, state),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, PhotographerPaymentState state) {
    final List<DataColumn> dataColumns = [
      const DataColumn(label: Text("No")),
      const DataColumn(label: Text("Aksi")),
      DataColumn(
        label: ColumnSort(
          label: "Nama Fotog",
          onTap: () {
            setState(() {
              if (sortBy == SortPhotographerPayment.name) {
                isAsc = !isAsc;
              } else {
                sortBy = SortPhotographerPayment.name;
                isAsc = true;
              }
            });
          },
        ),
      ),
      const DataColumn(label: Text("No Hp")),
      const DataColumn(label: Text("Instagram")),
      const DataColumn(label: Text("Total Sesi")),
      const DataColumn(label: Text("Sesi Dibaya")),
      const DataColumn(label: Text("Sesi Belum Dibayar")),
      const DataColumn(label: Text("Jumlah Dibayar")),
      const DataColumn(label: Text("Kurang Bayar")),
      DataColumn(
        label: ColumnSort(
          label: "Status",
          onTap: () {
            setState(() {
              if (sortBy == SortPhotographerPayment.status) {
                isAsc = !isAsc;
              } else {
                sortBy = SortPhotographerPayment.status;
                isAsc = true;
              }
            });
          },
        ),
      ),
    ];

    final List<DataRow> dataRows = state.items
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
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: const EdgeInsets.all(16),
                          child: FotograferDetailPage(
                            photographerId: e.value.id,
                          ),
                        ),
                      );
                    }
                    if (value == "Hapus") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hapus: ${e.value.name}'),
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
              DataCell(
                SizedBox(
                  width: 150,
                  child: Text(
                    e.value.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const DataCell(Text('628522647911')), // TODO: Get from data
              const DataCell(Text('@wirawiri')), // TODO: Get from data
              DataCell(Text(e.value.sessionCount.toString())),
              DataCell(Text(e.value.sessionPaid.toString())),
              DataCell(Text(e.value.sessionUnpaid.toString())),
              DataCell(
                Text(
                  currencyFormatter.format(e.value.paidAmount),
                  style: const TextStyle(color: Colors.green),
                ),
              ),
              DataCell(
                Text(
                  currencyFormatter.format(e.value.unpaidAmount),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              DataCell(
                _buildStatusChip(e.value.status),
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
        const SizedBox(height: 20),
        FooterTabel(
          back: state.currentPage > 0
              ? () {
                  ref
                      .read(
                        photographerPaymentProvider(
                          0,
                          limit,
                          search: searchQuery,
                          startTime: startTime,
                          endTime: endTime,
                          sortBy: sortBy,
                          sort: isAsc ? Sort.asc : Sort.desc,
                        ).notifier,
                      )
                      .back();
                }
              : null,
          next: state.metadata?.totalPages != (state.currentPage + 1)
              ? () {
                  ref
                      .read(
                        photographerPaymentProvider(
                          0,
                          limit,
                          search: searchQuery,
                          startTime: startTime,
                          endTime: endTime,
                          sortBy: sortBy,
                          sort: isAsc ? Sort.asc : Sort.desc,
                        ).notifier,
                      )
                      .appendData();
                }
              : null,
          jumlahPage: state.metadata?.totalPages ?? 0,
          currentPage: state.currentPage + 1,
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toUpperCase()) {
      case 'PENDING':
        color = MyColor.oren;
        break;
      case 'PAID':
        color = MyColor.hijauaccent;
        break;
      case 'UNPAID':
        color = Colors.red;
        break;
      default:
        color = MyColor.abudalamcontainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDateInput({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 8),
            Text(
              date != null
                  ? DateFormat('dd MMM yyyy').format(date)
                  : label,
              style: TextStyle(
                fontSize: 14,
                color: date != null ? Colors.white : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
