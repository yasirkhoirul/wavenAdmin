import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/whatsapp/send_whatsapp_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';

class DialogKirimWAClient extends ConsumerStatefulWidget {
  final String idBooking;
  const DialogKirimWAClient({super.key, required this.idBooking});

  @override
  ConsumerState<DialogKirimWAClient> createState() =>
      _DialogKirimWAClientState();
}

class _DialogKirimWAClientState extends ConsumerState<DialogKirimWAClient> {
  final TextEditingController pesanController = TextEditingController();

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
    String time,
  ) {
    return '''Hailoo kak $clientName, reminder untuk sesi foto besok ya kak, Untuk detailnya sebagai berikut :

🎓 Univ : $university
📍 Lokasi Foto : $location
📅 Waktu Foto : $eventDate jam $time

Selanjutnya kakak akan dihubungi oleh fotografer kami, mohon di tunggu, nanti bisa janjian ketentuan dengan fotografernya langsung ya kak. Terimakasihh''';
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
                data.eventStartTime
              );
            }

            final hasPhoneNumber = data.clientPhoneNumber.isNotEmpty;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kirim WA Client',
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
                                      sub: ItemDetailText(
                                        textSub: '#${data.id}',
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    ItemDetail(
                                      judul: 'Nama Client',
                                      sub: ItemDetailText(
                                        textSub: data.clientName,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    ItemDetail(
                                      judul: 'Instagram',
                                      sub: ItemDetailText(
                                        textSub: data.clientInstagram,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ItemDetail(
                                      judul: 'No Hp',
                                      sub: ItemDetailText(
                                        textSub: data.clientPhoneNumber.isNotEmpty
                                            ? data.clientPhoneNumber
                                            : '-',
                                      ),
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
                                            : data.photographerData
                                                  .map((p) => p.name)
                                                  .join(', '),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              // Right side - Message
                              Expanded(
                                child: _buildMessageSection(
                                  data,
                                  hasPhoneNumber,
                                ),
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
                                judul: 'Instagram',
                                sub: ItemDetailText(
                                  textSub: data.clientInstagram,
                                ),
                              ),
                              SizedBox(height: 12),
                              ItemDetail(
                                judul: 'No Hp',
                                sub: ItemDetailText(
                                  textSub: data.clientPhoneNumber.isNotEmpty
                                      ? data.clientPhoneNumber
                                      : '-',
                                ),
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
                                      : data.photographerData
                                            .map((p) => p.name)
                                            .join(', '),
                                ),
                              ),
                              SizedBox(height: 24),
                              _buildMessageSection(data, hasPhoneNumber),
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
                _buildFooter(context, hasPhoneNumber, data.clientPhoneNumber),
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
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

  Widget _buildMessageSection(dynamic data, bool hasPhoneNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pesan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(height: 12),

        // Validation messages
        if (!hasPhoneNumber)
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No WA client belum ada',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        if (data.photographerData.isEmpty)
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: hasPhoneNumber ? 0 : 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.orange),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Fotografer belum di set',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Message TextField (only show if phone number exists)
        if (hasPhoneNumber) ...[
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
                borderSide: BorderSide(
                  color: MyColor.abudalamcontainer,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFooter(BuildContext context, bool hasPhoneNumber, String phoneNumber) {
    final whatsappState = ref.watch(sendWhatsappProvider);
    
    return whatsappState.when(
      data: (message) {
        // Show success message
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
              teks: 'Kirim WA Client',
              ontap: hasPhoneNumber
                  ? () async {
                      if (pesanController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Pesan tidak boleh kosong'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      
                      await ref
                          .read(sendWhatsappProvider.notifier)
                          .sendMessage(phoneNumber, pesanController.text);
                    }
                  : null,
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
            Text('Mengirim pesan...'),
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
                    ref.read(sendWhatsappProvider.notifier).reset();
                  },
                  child: Text('Batal'),
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    await ref
                        .read(sendWhatsappProvider.notifier)
                        .sendMessage(phoneNumber, pesanController.text);
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
