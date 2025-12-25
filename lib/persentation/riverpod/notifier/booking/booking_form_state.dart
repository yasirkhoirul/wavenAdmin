import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/create_booking_request_model.dart';
import 'package:wavenadmin/domain/entity/detail_user.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';
import 'package:wavenadmin/domain/usecase/get_package_dropdown.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/domain/usecase/create_booking_usecase.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/userDetail.dart';

part 'booking_form_state.g.dart';

class BookingFormState {
  // User/Customer Data
  final String? selectedUserId;
  final DetailUser? selectedUserDetail;
  final TextEditingController fullNameController;
  final TextEditingController whatsappController;
  final TextEditingController instagramController;
  
  // Booking Data
  final Package? selectedPackage;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final String? startTime;
  final String? endTime;
  final TransactionPayMethod? selectedPaymentMethod;
  final TransactionPayType? selectedPaymentType;
  final List<Addon> selectedAddons;
  final double calculatedAmount;
  
  // Additional Data
  final University? selectedUniversity;
  final TextEditingController locationController;
  final TextEditingController noteController;
  
  // Evidence Image
  final XFile? selectedImage;
  
  // Package Detail Loading
  final bool isFetchingPackageDetail;
  
  // Form State
  final bool isSubmitting;
  final String? errorMessage;
  final GlobalKey<FormState> formKey;

  BookingFormState({
    this.selectedUserId,
    this.selectedUserDetail,
    TextEditingController? fullNameController,
    TextEditingController? whatsappController,
    TextEditingController? instagramController,
    this.selectedPackage,
    this.selectedDate,
    this.selectedTimeSlot,
    this.startTime,
    this.endTime,
    this.selectedPaymentMethod,
    this.selectedPaymentType,
    this.selectedAddons = const [],
    this.calculatedAmount = 0,
    this.selectedUniversity,
    TextEditingController? locationController,
    TextEditingController? noteController,
    this.selectedImage,
    this.isFetchingPackageDetail = false,
    this.isSubmitting = false,
    this.errorMessage,
    GlobalKey<FormState>? formKey,
  })  : fullNameController = fullNameController ?? TextEditingController(),
        whatsappController = whatsappController ?? TextEditingController(),
        instagramController = instagramController ?? TextEditingController(),
        locationController = locationController ?? TextEditingController(),
        noteController = noteController ?? TextEditingController(),
        formKey = formKey ?? GlobalKey<FormState>();

  BookingFormState copyWith({
    String? selectedUserId,
    DetailUser? selectedUserDetail,
    Package? selectedPackage,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    String? startTime,
    String? endTime,
    TransactionPayMethod? selectedPaymentMethod,
    TransactionPayType? selectedPaymentType,
    List<Addon>? selectedAddons,
    double? calculatedAmount,
    University? selectedUniversity,
    XFile? selectedImage,
    bool? isFetchingPackageDetail,
    bool? isSubmitting,
    String? errorMessage,
    bool clearImage = false,
  }) {
    return BookingFormState(
      selectedUserId: selectedUserId ?? this.selectedUserId,
      selectedUserDetail: selectedUserDetail ?? this.selectedUserDetail,
      fullNameController: fullNameController,
      whatsappController: whatsappController,
      instagramController: instagramController,
      selectedPackage: selectedPackage ?? this.selectedPackage,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      selectedPaymentType: selectedPaymentType ?? this.selectedPaymentType,
      selectedAddons: selectedAddons ?? this.selectedAddons,
      calculatedAmount: calculatedAmount ?? this.calculatedAmount,
      selectedUniversity: selectedUniversity ?? this.selectedUniversity,
      locationController: locationController,
      noteController: noteController,
      selectedImage: clearImage ? null : (selectedImage ?? this.selectedImage),
      isFetchingPackageDetail: isFetchingPackageDetail ?? this.isFetchingPackageDetail,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      formKey: formKey,
    );
  }

  void dispose() {
    fullNameController.dispose();
    whatsappController.dispose();
    instagramController.dispose();
    locationController.dispose();
    noteController.dispose();
  }
}

@riverpod
class BookingForm extends _$BookingForm {
  final ImagePicker _picker = ImagePicker();

  @override
  FutureOr<BookingFormState> build() async {
    return BookingFormState();
  }

  void setSelectedUser(String? userId) {
    final currentState = state.value;
    if (currentState == null) return;

    if (userId == null) {
      // Clear user data
      currentState.fullNameController.clear();
      currentState.whatsappController.clear();
      currentState.instagramController.clear();
      
      state = AsyncValue.data(currentState.copyWith(
        selectedUserId: null,
        selectedUserDetail: null,
      ));
      return;
    }

    // Set user ID and fetch details
    state = AsyncValue.data(currentState.copyWith(
      selectedUserId: userId,
    ));

    // Fetch user detail
    _fetchUserDetail(userId);
  }

  Future<void> _fetchUserDetail(String userId) async {
    try {
      final userDetail = await ref.read(userDetailProvider(userId).future);
      final currentState = state.value;
      if (currentState == null) return;

      // Populate form fields
      currentState.fullNameController.text = userDetail.name;
      currentState.whatsappController.text = userDetail.phoneNumber ?? '';
      currentState.instagramController.text = '';

      state = AsyncValue.data(currentState.copyWith(
        selectedUserDetail: userDetail,
      ));
    } catch (e) {
      Logger().e('Error fetching user detail: $e');
      state = AsyncValue.data(state.value!.copyWith(
        errorMessage: 'Gagal mengambil detail user: $e',
      ));
    }
  }

  void setPackage(Package? package) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      selectedPackage: package,
    ));
    
    // Fetch package detail to get accurate price
    if (package != null) {
      _fetchPackageDetail(package.id);
    }
  }

  Future<void> _fetchPackageDetail(String packageId) async {
    final currentState = state.value;
    if (currentState == null) return;

    // Set loading state
    state = AsyncValue.data(currentState.copyWith(
      isFetchingPackageDetail: true,
      errorMessage: null,
    ));

    try {
      final usecase = locator<GetPackageDropdown>();
      final packageDetail = await usecase.getPackageDetail(packageId);
      
      final updatedState = state.value;
      if (updatedState == null) return;

      // Update package with accurate price from detail
      final updatedPackage = Package(
        id: packageDetail.data.id,
        title: packageDetail.data.title,
        price: packageDetail.data.price,
      );

      state = AsyncValue.data(updatedState.copyWith(
        selectedPackage: updatedPackage,
        isFetchingPackageDetail: false,
      ));
      
      // Automatically calculate amount after package is set
      calculateAmount();
    } catch (e) {
      Logger().e('Error fetching package detail: $e');
      final errorState = state.value;
      if (errorState == null) return;
      
      state = AsyncValue.data(errorState.copyWith(
        isFetchingPackageDetail: false,
        errorMessage: 'Gagal mengambil detail package: $e',
      ));
    }
  }

  void setDate(DateTime? date) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      selectedDate: date,
    ));
  }

  void setTimeSlot(String? timeSlot) {
    final currentState = state.value;
    if (currentState == null || timeSlot == null) return;

    // Parse timeSlot "HH:MM-HH:MM" to extract start and end times
    final times = timeSlot.split('-');
    if (times.length != 2) return;

    state = AsyncValue.data(currentState.copyWith(
      selectedTimeSlot: timeSlot,
      startTime: times[0].trim(),
      endTime: times[1].trim(),
    ));
  }

  void setPaymentMethod(TransactionPayMethod? method) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      selectedPaymentMethod: method,
      clearImage: method != TransactionPayMethod.transfer,
    ));
  }

  void setPaymentType(TransactionPayType? type) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      selectedPaymentType: type,
    ));
    
    // Automatically recalculate when payment type changes
    calculateAmount();
  }

  void addAddon(Addon addon) {
    final currentState = state.value;
    if (currentState == null) return;

    final newAddons = List<Addon>.from(currentState.selectedAddons);
    if (!newAddons.any((a) => a.id == addon.id)) {
      newAddons.add(addon);
      
      state = AsyncValue.data(currentState.copyWith(
        selectedAddons: newAddons,
      ));
      
      // Automatically calculate amount after adding addon
      calculateAmount();
    }
  }

  void removeAddon(Addon addon) {
    final currentState = state.value;
    if (currentState == null) return;

    final newAddons = List<Addon>.from(currentState.selectedAddons);
    newAddons.removeWhere((a) => a.id == addon.id);
    
    state = AsyncValue.data(currentState.copyWith(
      selectedAddons: newAddons,
    ));
    
    // Automatically calculate amount after removing addon
    calculateAmount();
  }

  void setUniversity(University? university) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      selectedUniversity: university,
    ));
  }

  void calculateAmount() {
    final currentState = state.value;
    if (currentState == null) return;

    double amount = 0;

    // Add package price
    if (currentState.selectedPackage != null && currentState.selectedPackage!.price != null) {
      amount += currentState.selectedPackage!.price!.toDouble();
    }

    // Add addons prices
    for (final addon in currentState.selectedAddons) {
      amount += addon.price.toDouble();
    }

    // Apply payment type (dp = 50%)
    if (currentState.selectedPaymentType == TransactionPayType.dp) {
      amount = amount / 2;
    }

    state = AsyncValue.data(currentState.copyWith(
      calculatedAmount: amount,
    ));
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (image != null) {
        final currentState = state.value;
        if (currentState == null) return;

        state = AsyncValue.data(currentState.copyWith(
          selectedImage: image,
        ));
      }
    } catch (e) {
      Logger().e('Error picking image: $e');
    }
  }

  Future<bool> submit() async {
    final currentState = state.value;
    if (currentState == null) return false;

    // Validations
    if (!currentState.formKey.currentState!.validate()) {
      return false;
    }

    if (currentState.selectedUserId == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan pilih user',
      ));
      return false;
    }

    if (currentState.selectedPackage == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan pilih package',
      ));
      return false;
    }

    if (currentState.selectedDate == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan pilih tanggal',
      ));
      return false;
    }

    if (currentState.startTime == null || currentState.endTime == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan pilih waktu',
      ));
      return false;
    }

    if (currentState.selectedPaymentMethod == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan pilih metode pembayaran',
      ));
      return false;
    }

    if (currentState.selectedPaymentType == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan pilih tipe pembayaran',
      ));
      return false;
    }

    if (currentState.selectedPaymentMethod == TransactionPayMethod.transfer && 
        currentState.selectedImage == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan upload bukti transfer',
      ));
      return false;
    }

    if (currentState.selectedUniversity == null) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan pilih universitas',
      ));
      return false;
    }

    if (currentState.locationController.text.trim().isEmpty) {
      state = AsyncValue.data(currentState.copyWith(
        errorMessage: 'Silakan isi lokasi',
      ));
      return false;
    }

    state = AsyncValue.data(currentState.copyWith(
      isSubmitting: true,
      errorMessage: null,
    ));

    try {
      final usecase = locator<CreateBookingUsecase>();
      final dateStr = '${currentState.selectedDate!.year}-${currentState.selectedDate!.month.toString().padLeft(2, '0')}-${currentState.selectedDate!.day.toString().padLeft(2, '0')}';
      
      final request = CreateBookingRequest(
        customerData: CustomerData(
          userId: currentState.selectedUserId!,
          fullName: currentState.fullNameController.text.trim(),
          whatsappNumber: currentState.whatsappController.text.trim(),
          instagram: currentState.instagramController.text.trim(),
        ),
        bookingData: BookingData(
          packageId: currentState.selectedPackage!.id,
          date: dateStr,
          startTime: currentState.startTime!,
          endTime: currentState.endTime!,
          paymentMethod: currentState.selectedPaymentMethod!.name,
          paymentType: currentState.selectedPaymentType!.name,
          amount: currentState.calculatedAmount,
          addonIds: currentState.selectedAddons.map((a) => a.id).toList(),
        ),
        additionalData: AdditionalData(
          universityId: currentState.selectedUniversity!.id,
          location: currentState.locationController.text.trim(),
          note: currentState.noteController.text.trim(),
        ),
      );

      await usecase.execute(request, currentState.selectedImage);

      state = AsyncValue.data(currentState.copyWith(
        isSubmitting: false,
      ));

      return true;
    } catch (e) {
      Logger().e('Error creating booking: $e');
      state = AsyncValue.data(currentState.copyWith(
        isSubmitting: false,
        errorMessage: 'Gagal membuat booking: $e',
      ));
      return false;
    }
  }
}
