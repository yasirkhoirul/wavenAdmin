import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/fotografer_detail.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/whatsapp/send_whatsapp_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';

class DialogKirimWAFotografer extends ConsumerStatefulWidget {
  final String idBooking;
  const DialogKirimWAFotografer({super.key, required this.idBooking});

  @override
  ConsumerState<DialogKirimWAFotografer> createState() => _DialogKirimWAFotograferState();
}

class _DialogKirimWAFotograferState extends ConsumerState<DialogKirimWAFotografer> {
  final TextEditingController pesanController = TextEditingController();
  bool _isSending = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    pesanController.dispose();
    super.dispose();
  }

  String _generateDefaultMessage(
    String clientName,
    String university,
    String location,
    String eventDate,
  ) {
    return '''Halo fotografer, berikut detail booking untuk sesi foto besok:

👤 Client : $clientName
🎓 Universitas : $university
📍 Lokasi Foto : $location
📅 Waktu Foto : $eventDate

Mohon segera konfirmasi dan hubungi client untuk koordinasi lebih lanjut. Terima kasih!''';
  }

  Future<void> _sendToAllPhotographers(dynamic data) async {
    if (pesanController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Pesan tidak boleh kosong';
      });
      return;
    }

    setState(() {
      _isSending = true;
      _errorMessage = null;
      _successMessage = null;
    });

    int successCount = 0;
    int failedCount = 0;
    List<String> failedPhotographers = [];

    for (var photographer in data.photographerData) {
      try {
        // Fetch photographer detail to get phone number
        final fotograferDetail = await ref.read(
          fotograferDetailProvider(photographer.id).future
        );

        if (fotograferDetail.phoneNumber != null && 
            fotograferDetail.phoneNumber!.isNotEmpty) {
          // Send via API
          await ref
              .read(sendWhatsappProvider.notifier)
              .sendMessage(
                fotograferDetail.phoneNumber!,
                pesanController.text.trim(),
              );
          
          // Check if send was successful
          final sendState = ref.read(sendWhatsappProvider);
          if (sendState.hasError) {
            failedCount++;
            failedPhotographers.add(photographer.name);
          } else {
            successCount++;
          }
          
          // Small delay between messages
          await Future.delayed(Duration(milliseconds: 500));
        }
      } catch (e) {
        failedCount++;
        failedPhotographers.add(photographer.name);
        continue;
      }
    }

    setState(() {
      _isSending = false;
      if (successCount > 0 && failedCount == 0) {
        _successMessage = 'Pesan berhasil dikirim ke $successCount fotografer';
      } else if (successCount > 0 && failedCount > 0) {
        _errorMessage = 'Berhasil: $successCount, Gagal: $failedCount fotografer (${failedPhotographers.join(", ")})';
      } else {
        _errorMessage = 'Tidak ada fotografer dengan nomor telepon yang valid atau semua pengiriman gagal';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailBookingProvider(widget.idBooking));

    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 1000,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: EdgeInsets.all(24),
        child: state.when(
          data: (data) {
            // Initialize message if controller is empty
            if (pesanController.text.isEmpty) {
              pesanController.text = _generateDefaultMessage(
                data.clientName,
                data.university,
                data.location,
                data.eventDate,
              );
            }

            final hasFotografer = data.photographerData.isNotEmpty;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kirim WA Fotografer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 16),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideScreen = constraints.maxWidth > 900;
                        
                        if (isWideScreen) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left side - Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ItemDetail(
                                      judul: 'ID Booking',
                                      sub: ItemDetailText(textSub: '#${data.id}'),
                                    ),
                                    SizedBox(height: 12),
                                    ItemDetail(
                                      judul: 'Nama Client',
                                      sub: ItemDetailText(textSub: data.clientName),
                                    ),
                                    SizedBox(height: 12),
                                    ItemDetail(
                                      judul: 'Lokasi Foto',
                                      sub: ItemDetailText(textSub: data.location),
                                    ),
                                    SizedBox(height: 12),
                                    ItemDetail(
                                      judul: 'Fotografer',
                                      sub: ItemDetailText(
                                        textSub: data.photographerData.isEmpty
                                            ? '-'
                                            : data.photographerData.map((p) => p.name).join(', '),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    ItemDetail(
                                      judul: 'Status Foto',
                                      sub: ItemDetailText(
                                        textSub: data.alreadyPhoto ? 'Sudah Foto' : 'Belum Foto',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              // Right side - Message
                              Expanded(
                                child: _buildMessageSection(hasFotografer),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ItemDetail(
                                judul: 'ID Booking',
                                sub: ItemDetailText(textSub: '#${data.id}'),
                              ),
                              SizedBox(height: 12),
                              ItemDetail(
                                judul: 'Nama Client',
                                sub: ItemDetailText(textSub: data.clientName),
                              ),
                              SizedBox(height: 12),
                              ItemDetail(
                                judul: 'Lokasi Foto',
                                sub: ItemDetailText(textSub: data.location),
                              ),
                              SizedBox(height: 12),
                              ItemDetail(
                                judul: 'Fotografer',
                                sub: ItemDetailText(
                                  textSub: data.photographerData.isEmpty
                                      ? '-'
                                      : data.photographerData.map((p) => p.name).join(', '),
                                ),
                              ),
                              SizedBox(height: 12),
                              ItemDetail(
                                judul: 'Status Foto',
                                sub: ItemDetailText(
                                  textSub: data.alreadyPhoto ? 'Sudah Foto' : 'Belum Foto',
                                ),
                              ),
                              SizedBox(height: 24),
                              _buildMessageSection(hasFotografer),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),

                // Footer buttons
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 16),
                _buildFooter(data, hasFotografer),
              ],
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error, color: Colors.red, size: 48),
                SizedBox(height: 16),
                Text('Error: $error'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Tutup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageSection(bool hasFotografer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pesan',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 12),

        // Validation message
        if (!hasFotografer)
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Fotografer belum di set',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Message TextField (only show if photographer exists)
        if (hasFotografer) ...[
          SizedBox(height: 12),
          TextFormField(
            controller: pesanController,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Tulis pesan...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: MyColor.abudalamcontainer),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: MyColor.abudalamcontainer),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: MyColor.abudalamcontainer, width: 2),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFooter(dynamic data, bool hasFotografer) {
    // Show success message
    if (_successMessage != null) {
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
                    _successMessage!,
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
                  ref.read(sendWhatsappProvider.notifier).reset();
                  Navigator.pop(context);
                },
                child: Text('Tutup'),
              ),
            ],
          ),
        ],
      );
    }

    // Show error message with retry
    if (_errorMessage != null) {
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
                    _errorMessage!,
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
                  setState(() {
                    _errorMessage = null;
                    _successMessage = null;
                  });
                },
                child: Text('Batal'),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _sendToAllPhotographers(data),
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
    }

    // Show loading state
    if (_isSending) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text('Mengirim pesan ke fotografer...'),
        ],
      );
    }

    // Show normal buttons
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        SizedBox(width: 12),
        LButtonWeb(
          icon: Icons.send,
          teks: 'Kirim WA Fotografer',
          ontap: hasFotografer
              ? () => _sendToAllPhotographers(data)
              : null,
        ),
      ],
    );
  }
}
