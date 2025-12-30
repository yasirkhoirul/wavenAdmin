import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';
import 'package:wavenadmin/common/web_helper.dart';

part 'transaction_form_state.g.dart';

class TransactionFormState {
  final String bookingId;
  final String bookingStatus;
  final double unpaidAmount;
  final TransactionPayType? selectedPaymentType;
  final TransactionPayMethod? selectedPaymentMethod;
  final double amount;
  final XFile? selectedImage;
  final Uint8List? qrCodeImage;
  final String? gatewayTransactionId;
  final bool isQrisPaid;
  final bool isGeneratingQR;
  final bool isSubmitting;
  final bool isCheckingPayment;
  final String? errorMessage;
  final GlobalKey<FormState> formKey;

  TransactionFormState({
    required this.bookingId,
    required this.bookingStatus,
    required this.unpaidAmount,
    this.selectedPaymentType,
    this.selectedPaymentMethod,
    this.amount = 0,
    this.selectedImage,
    this.qrCodeImage,
    this.gatewayTransactionId,
    this.isQrisPaid = false,
    this.isGeneratingQR = false,
    this.isSubmitting = false,
    this.isCheckingPayment = false,
    this.errorMessage,
    GlobalKey<FormState>? formKey,
  }) : formKey = formKey ?? GlobalKey<FormState>();

  TransactionFormState copyWith({
    TransactionPayType? selectedPaymentType,
    TransactionPayMethod? selectedPaymentMethod,
    double? amount,
    XFile? selectedImage,
    Uint8List? qrCodeImage,
    String? gatewayTransactionId,
    bool? isQrisPaid,
    bool? isGeneratingQR,
    bool? isSubmitting,
    bool? isCheckingPayment,
    String? errorMessage,
    bool clearImage = false,
    bool clearQR = false,
    bool clearGatewayId = false,
  }) {
    return TransactionFormState(
      bookingId: bookingId,
      bookingStatus: bookingStatus,
      unpaidAmount: unpaidAmount,
      selectedPaymentType: selectedPaymentType ?? this.selectedPaymentType,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      amount: amount ?? this.amount,
      selectedImage: clearImage ? null : (selectedImage ?? this.selectedImage),
      qrCodeImage: clearQR ? null : (qrCodeImage ?? this.qrCodeImage),
      gatewayTransactionId: clearGatewayId ? null : (gatewayTransactionId ?? this.gatewayTransactionId),
      isQrisPaid: isQrisPaid ?? this.isQrisPaid,
      isGeneratingQR: isGeneratingQR ?? this.isGeneratingQR,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isCheckingPayment: isCheckingPayment ?? this.isCheckingPayment,
      errorMessage: errorMessage,
      formKey: formKey,
    );
  }
}

@riverpod
class TransactionForm extends _$TransactionForm {
  final ImagePicker _picker = ImagePicker();

  @override
  FutureOr<TransactionFormState> build(String bookingId) async {
    final bookingDetail = await ref.watch(detailBookingProvider(bookingId).future);
    
    final bookingStatus = bookingDetail.status.toUpperCase();
    final unpaidAmount = bookingDetail.unpaidAmount.toDouble();
    
    // Auto-set payment type if booking is DP
    final initialPaymentType = bookingStatus == StatusBooking.DP.name 
        ? TransactionPayType.pelunasan 
        : null;
    
    final initialAmount = initialPaymentType != null ? unpaidAmount : 0.0;

    return TransactionFormState(
      bookingId: bookingId,
      bookingStatus: bookingStatus,
      unpaidAmount: unpaidAmount,
      selectedPaymentType: initialPaymentType,
      amount: initialAmount,
    );
  }

  void setPaymentType(TransactionPayType? type) {
    final currentState = state.value;
    if (currentState == null || type == null) return;

    double amount;
    switch (type) {
      case TransactionPayType.dp:
        amount = currentState.unpaidAmount / 2;
        break;
      case TransactionPayType.lunas:
      case TransactionPayType.pelunasan:
        amount = currentState.unpaidAmount;
        break;
    }

    state = AsyncValue.data(currentState.copyWith(
      selectedPaymentType: type,
      amount: amount,
    ));
  }

  void setPaymentMethod(TransactionPayMethod? method) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      selectedPaymentMethod: method,
      clearImage: method != TransactionPayMethod.transfer,
      clearQR: method != TransactionPayMethod.qris,
    ));
  }

  Future<void> pickImage(ImageSource source) async {
    Logger().d("pick image ditekan");
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final currentState = state.value;
        if (currentState != null) {
          state = AsyncValue.data(currentState.copyWith(selectedImage: image));
        }
      }
    } catch (e) {
      Logger().e("pick image ditekan error $e");
      final currentState = state.value;
      if (currentState != null) {
        state = AsyncValue.data(currentState.copyWith(
          errorMessage: 'Error memilih gambar: $e',
        ));
      }
    }
  }

  Future<void> generateQRCode() async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(isGeneratingQR: true));

    try {
      // TODO: Call API to get QR code
      // final qrImage = await ref.read(getQRCodeUsecase).execute(bookingId);
      
      // Placeholder: For now, just simulate delay
      await Future.delayed(Duration(seconds: 2));
      
      // TODO: Replace with actual API response
      // state = AsyncValue.data(currentState.copyWith(
      //   qrCodeImage: qrImage,
      //   isGeneratingQR: false,
      // ));
      
      state = AsyncValue.data(currentState.copyWith(
        isGeneratingQR: false,
        errorMessage: 'QR Code API belum diimplementasikan',
      ));
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        isGeneratingQR: false,
        errorMessage: 'Error generating QR: $e',
      ));
    }
  }

  Future<bool> submit() async {
    final currentState = state.value;
    if (currentState == null) return false;

    if (!currentState.formKey.currentState!.validate()) {
      return false;
    }

    // Validation for transfer method
    if (currentState.selectedPaymentMethod == TransactionPayMethod.transfer) {
      if (currentState.selectedImage == null) {
        state = AsyncValue.data(currentState.copyWith(
          errorMessage: 'Bukti transfer wajib diisi',
        ));
        return false;
      }
    }

    state = AsyncValue.data(currentState.copyWith(isSubmitting: true));

    try {
      final request = CreateTransactionRequest(
        paymentType: currentState.selectedPaymentType!.name,
        paymentMethod: currentState.selectedPaymentMethod!.name,
        amount: currentState.amount,
        platform:kIsWeb? Platform.web.name:Platform.android.name,
      );


      final response = await ref.read(createTransactionUsecaseProvider).execute(
        currentState.bookingId,
        request,
        currentState.selectedImage,
      );
      if(kIsWeb && response.data?.actions!=null && response.data?.actions?.redirectUrl!=null&&response.data?.actions?.token!=null){
         
        openUrlInNewTab(response.data?.actions?.redirectUrl ?? '');
      
      }
      // Refresh booking detail
      await ref.read(detailBookingProvider(currentState.bookingId).notifier).onRefresh();

      // Handle QRIS response
      if (currentState.selectedPaymentMethod == TransactionPayMethod.qris) {
        final gatewayId = response.data?.transactionDetail.gatewayTransactionId;
        if (gatewayId != null) {
          // Get QR code image
          final qrImage = await ref.read(createTransactionUsecaseProvider).getQrisImage(gatewayId);
          state = AsyncValue.data(currentState.copyWith(
            qrCodeImage: Uint8List.fromList(qrImage),
            gatewayTransactionId: gatewayId,
            isSubmitting: false,
          ));
          return true;
        }
      }

      state = AsyncValue.data(currentState.copyWith(isSubmitting: false));
      return true;
    } catch (e) {
      
      state = AsyncValue.data(currentState.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }

  Future<void> checkQrisPaymentStatus() async {
    final currentState = state.value;
    if (currentState == null || currentState.gatewayTransactionId == null) return;

    state = AsyncValue.data(currentState.copyWith(isCheckingPayment: true));

    try {
      final response = await ref.read(createTransactionUsecaseProvider).checkQrisPaymentStatus(
        currentState.bookingId,
        currentState.gatewayTransactionId!,
      );

      state = AsyncValue.data(currentState.copyWith(
        isQrisPaid: response.data.isPaid,
        isCheckingPayment: false,
        errorMessage: response.data.description,
      ));

      // Refresh booking if paid
      if (response.data.isPaid) {
        await ref.read(detailBookingProvider(currentState.bookingId).notifier).onRefresh();
      }
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        isCheckingPayment: false,
        errorMessage: 'Error cek pembayaran: $e',
      ));
    }
  }
}
