import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/persentation/pages/fotografer_mangement_page.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/photographer_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/photographer_detail_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_booking_state.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_detail_state.dart';
import 'package:wavenadmin/persentation/widget/outlined_searchbar.dart';
import 'package:wavenadmin/persentation/widget/tabelcontent.dart';

class FotograferDetailPage extends ConsumerStatefulWidget {
  final String photographerId;

  const FotograferDetailPage({super.key, required this.photographerId});

  @override
  ConsumerState<FotograferDetailPage> createState() =>
      _FotograferDetailPageState();
}

class _FotograferDetailPageState extends ConsumerState<FotograferDetailPage> {
  final TextEditingController searchController = TextEditingController();
  int limit = 10;
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
    final detailState = ref.watch(
      photographerDetailProvider(widget.photographerId),
    );

    final bookingState = ref.watch(
      photographerBookingProvider(
        widget.photographerId,
        0,
        limit,
        search: searchQuery,
        startTime: startTime,
        endTime: endTime,
      ),
    );

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with close button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photographer Details Section
                  _buildPhotographerDetails(detailState),
                  const SizedBox(height: 30),

                  // Client Section Header
                  const Text(
                    "Client",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search Bar and Filter
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
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
                      _buildDateRangeButton(context),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Payment Summary Cards
                  if (detailState.requestState == RequestState.succes &&
                      detailState.detail != null)
                    _buildPaymentSummary(detailState),

                  const SizedBox(height: 20),

                  // Booking List Table
                  bookingState.requestState == RequestState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : bookingState.requestState == RequestState.error
                          ? Center(
                              child: Column(
                                children: [
                                  Text('Error: ${bookingState.message}'),
                                  ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                            photographerBookingProvider(
                                              widget.photographerId,
                                              0,
                                              limit,
                                              search: searchQuery,
                                              startTime: startTime,
                                              endTime: endTime,
                                            ).notifier,
                                          )
                                          .refresh();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            )
                          : _buildBookingTable(context, bookingState),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotographerDetails(PhotographerDetailState state) {
    if (state.requestState == RequestState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.requestState == RequestState.error) {
      return Center(
        child: Column(
          children: [
            Text('Error: ${state.message}'),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(photographerDetailProvider(widget.photographerId)
                        .notifier)
                    .refresh();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.detail == null) {
      return const Center(child: Text('No data'));
    }

    final photographer = state.detail!.photographerData;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Photographer",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nama Fotografer",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      photographer.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No Hp",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      photographer.phoneNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Fee",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currencyFormatter.format(photographer.feePerHour),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Rekening",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          photographer.bankAccount,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "44219313213", // TODO: Get actual account number from API
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDateRange: startTime != null && endTime != null
              ? DateTimeRange(start: startTime!, end: endTime!)
              : null,
        );

        if (picked != null) {
          setState(() {
            startTime = picked.start;
            endTime = picked.end;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.filter_alt, size: 16, color: Colors.white),
            const SizedBox(width: 8),
            const Text("Filter", style: TextStyle(color: Colors.white)),
            const SizedBox(width: 8),
            Text(
              startTime != null && endTime != null
                  ? "${DateFormat('dd MMM yy').format(startTime!)} - ${DateFormat('dd MMM yy').format(endTime!)}"
                  : "18 Nov 25 - 25 Des 25",
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary(PhotographerDetailState state) {
    final payment = state.detail!.paymentData;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            "Total Belum Dibayar",
            currencyFormatter.format(payment.unpaidAmount),
            Colors.grey[200]!,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            "Total Sudah Dibayar",
            currencyFormatter.format(payment.paidAmount),
            Colors.grey[200]!,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            "Total Client",
            "${payment.sessionCount} Client",
            Colors.grey[200]!,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingTable(
      BuildContext context, PhotographerBookingState state) {
    final List<DataColumn> dataColumns = [
      const DataColumn(label: Text("No")),
      const DataColumn(label: Text("Aksi")),
      const DataColumn(label: Text("Tanggal Foto")),
      const DataColumn(label: Text("Nama client")),
      const DataColumn(label: Text("Universitas")),
      const DataColumn(label: Text("Package")),
      const DataColumn(label: Text("Add on")),
      const DataColumn(label: Text("Fee Fotogafer")),
      const DataColumn(label: Text("Status")),
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
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == "Detail") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Detail: ${e.value.clientName}'),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => ["Detail"]
                      .map(
                        (action) =>
                            PopupMenuItem(value: action, child: Text(action)),
                      )
                      .toList(),
                ),
              ),
              DataCell(
                Text(
                  DateFormat('dd MMM yyyy').format(
                    DateTime.parse(e.value.eventDate),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 150,
                  child: Text(
                    e.value.clientName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 120,
                  child: Text(
                    e.value.universityName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 120,
                  child: Text(
                    e.value.packageName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 150,
                  child: Text(
                    e.value.addons.isNotEmpty
                        ? e.value.addons.map((a) => a.title).join(', ')
                        : '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              DataCell(
                Text(currencyFormatter.format(e.value.fee)),
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
                        photographerBookingProvider(
                          widget.photographerId,
                          0,
                          limit,
                          search: searchQuery,
                          startTime: startTime,
                          endTime: endTime,
                        ).notifier,
                      )
                      .back();
                }
              : null,
          next: state.metadata?.totalPages != (state.currentPage + 1)
              ? () {
                  ref
                      .read(
                        photographerBookingProvider(
                          widget.photographerId,
                          0,
                          limit,
                          search: searchQuery,
                          startTime: startTime,
                          endTime: endTime,
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
        color = Colors.orange;
        break;
      case 'LUNAS':
        color = Colors.green;
        break;
      case 'BELUM LUNAS':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
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
}
