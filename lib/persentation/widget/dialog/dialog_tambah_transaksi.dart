import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/transaction_form_state.dart';

class DialogTambahTransaksi extends ConsumerWidget {
  final String idBooking;

  const DialogTambahTransaksi({
    super.key,
    required this.idBooking,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(transactionFormProvider(idBooking));
    final notifier = ref.read(transactionFormProvider(idBooking).notifier);
    
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500, maxHeight: 650),
        padding: EdgeInsets.all(24),
        child: formState.when(
          data: (state) {
            Logger().d("form state ${state.amount}");
            return _buildForm(context, ref, state, notifier);},
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

  Widget _buildForm(
    BuildContext context,
    WidgetRef ref,
    TransactionFormState state,
    TransactionForm notifier,
  ) {
    final isBookingDP = state.bookingStatus == StatusBooking.DP.name;
    final isBookingPending = state.bookingStatus == StatusBooking.PENDING.name;
    Logger().d("state ${state.amount}");
    return Form(
      key: state.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tambah Transaksi',
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
            
            // Payment Type
            Text('Tipe Pembayaran *', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            DropdownButtonFormField<TransactionPayType>(
              value: state.selectedPaymentType,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih tipe pembayaran',
              ),
              items: isBookingDP
                  ? [
                      DropdownMenuItem(
                        value: TransactionPayType.pelunasan,
                        child: Text('Pelunasan'),
                      ),
                    ]
                  : isBookingPending
                      ? [
                          DropdownMenuItem(
                            value: TransactionPayType.dp,
                            child: Text('DP'),
                          ),
                          DropdownMenuItem(
                            value: TransactionPayType.lunas,
                            child: Text('Lunas'),
                          ),
                        ]
                      : TransactionPayType.values
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type.name.toUpperCase()),
                              ))
                          .toList(),
              onChanged: isBookingDP ? null : (value)  {
                Logger().d("diganti type : $value");
                notifier.setPaymentType(value);},
              validator: (value) => value == null ? 'Tipe pembayaran wajib dipilih' : null,
            ),
            SizedBox(height: 16),

            // Payment Method
            Text('Metode Pembayaran *', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            DropdownButtonFormField<TransactionPayMethod>(
              value: state.selectedPaymentMethod,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih metode pembayaran',
              ),
              items: TransactionPayMethod.values
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) => notifier.setPaymentMethod(value),
              validator: (value) => value == null ? 'Metode pembayaran wajib dipilih' : null,
            ),
            SizedBox(height: 16),

            // Amount
            Text('Jumlah Bayar *', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextFormField(
              key: ValueKey(state.amount),
              initialValue: state.amount > 0 ? state.amount.toStringAsFixed(0) : '',
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Otomatis terisi',
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
              readOnly: true,
              validator: (value) => value == null || value.isEmpty ? 'Jumlah bayar wajib diisi' : null,
            ),
            SizedBox(height: 16),

            // Evidence Section
            if (state.selectedPaymentMethod == TransactionPayMethod.transfer) ...[
              Text('Bukti Transfer *', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              if (state.selectedImage != null) ...[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FutureBuilder<Uint8List>(
                      future: state.selectedImage!.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => notifier.pickImage(ImageSource.gallery),
                      icon: Icon(Icons.photo_library),
                      label: Text(state.selectedImage == null ? 'Pilih Gambar' : 'Ganti Gambar'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => notifier.pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt),
                      label: Text('Kamera'),
                    ),
                  ),
                ],
              ),
              if (state.selectedImage == null)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Bukti transfer wajib diisi',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              SizedBox(height: 16),
            ] else if (state.selectedPaymentMethod == TransactionPayMethod.qris) ...[
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.qr_code, color: MyColor.birutua),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'QR Code akan ditampilkan setelah submit transaksi',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],

            // Info Box
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: MyColor.abucontainer,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '• Total Belum Dibayar: Rp ${state.unpaidAmount.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• DP: Rp ${(state.unpaidAmount / 2).toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• Lunas: Rp ${state.unpaidAmount.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Submit Button / QR Code Result
            if (state.qrCodeImage != null && state.selectedPaymentMethod == TransactionPayMethod.qris) ...[
              // Show QR Code after QRIS submission
              if (state.isQrisPaid) ...[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 64),
                      SizedBox(height: 16),
                      Text(
                        'Pembayaran QRIS Berhasil!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        state.errorMessage ?? 'Transaksi telah dibayar',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.hijauaccent,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Tutup'),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      state.qrCodeImage!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                state.isCheckingPayment
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: () => notifier.checkQrisPaymentStatus(),
                        icon: Icon(Icons.refresh),
                        label: Text('Cek Pembayaran'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.birutua,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Tutup'),
                ),
              ],
            ] else
              state.isSubmitting
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        final success = await notifier.submit();
                        if (success && context.mounted) {
                          if (state.selectedPaymentMethod != TransactionPayMethod.qris) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Transaksi berhasil ditambahkan')),
                            );
                            Navigator.pop(context);
                          }
                          // For QRIS, don't close dialog - show QR code
                        } else if (!success && context.mounted) {
                          Logger().e(state.errorMessage);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage ?? 'Gagal menambahkan transaksi')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.hijauaccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Simpan Transaksi'),
                    ),
          ],
        ),
      ),
    );
  }
}
