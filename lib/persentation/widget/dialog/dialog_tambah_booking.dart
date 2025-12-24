import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/get_list_addons_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/booking_form_state.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/get_package_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/get_university_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/user_list_notifier.dart';

class DialogTambahBooking extends ConsumerStatefulWidget {
  const DialogTambahBooking({super.key});

  @override
  ConsumerState<DialogTambahBooking> createState() => _DialogTambahBookingState();
}

class _DialogTambahBookingState extends ConsumerState<DialogTambahBooking> {
  String? _selectedUserId;
  final _searchUserController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch all necessary data when dialog opens
    Future.microtask(() {
      ref.read(userGetListProvider.notifier).getListUsers(100);
      // Package, addons, and university providers will auto-fetch when watched
    });
  }

  @override
  void dispose() {
    _searchUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(bookingFormProvider);
    final notifier = ref.read(bookingFormProvider.notifier);

    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: 800, maxHeight: MediaQuery.of(context).size.height * 0.9),
        padding: EdgeInsets.all(24),
        child: formState.when(
          data: (state) => _buildForm(context, ref, state, notifier),
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
    BookingFormState state,
    BookingForm notifier,
  ) {
    return Form(
      key: state.formKey,
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tambah Booking',
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
          
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Section: Customer Data
                  _buildSectionTitle('Data Customer'),
                  SizedBox(height: 12),
                  
                  // User Dropdown
                  _buildUserDropdown(ref, state, notifier),
                  SizedBox(height: 16),
                  
                  // Full Name
                  TextFormField(
                    controller: state.fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty 
                        ? 'Nama lengkap wajib diisi' 
                        : null,
                  ),
                  SizedBox(height: 16),
                  
                  // WhatsApp Number
                  TextFormField(
                    controller: state.whatsappController,
                    decoration: InputDecoration(
                      labelText: 'Nomor WhatsApp *',
                      border: OutlineInputBorder(),
                      prefixText: '+62 ',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.isEmpty 
                        ? 'Nomor WhatsApp wajib diisi' 
                        : null,
                  ),
                  SizedBox(height: 16),
                  
                  // Instagram
                  TextFormField(
                    controller: state.instagramController,
                    decoration: InputDecoration(
                      labelText: 'Instagram *',
                      border: OutlineInputBorder(),
                      prefixText: '@',
                    ),
                    validator: (value) => value == null || value.isEmpty 
                        ? 'Instagram wajib diisi' 
                        : null,
                  ),
                  SizedBox(height: 24),
                  
                  // Section: Booking Data
                  _buildSectionTitle('Data Booking'),
                  SizedBox(height: 12),
                  
                  // Package Dropdown
                  _buildPackageDropdown(ref, state, notifier),
                  SizedBox(height: 16),
                  
                  // Addons Dropdown
                  _buildAddonsDropdown(ref, state, notifier),
                  SizedBox(height: 16),
                  
                  // Date Picker
                  _buildDatePicker(context, state, notifier),
                  SizedBox(height: 16),
                  
                  // Time Slot Dropdown
                  _buildTimeSlotDropdown(state, notifier),
                  SizedBox(height: 16),
                  
                  // Payment Method
                  _buildPaymentMethodDropdown(state, notifier),
                  SizedBox(height: 16),
                  
                  // Payment Type
                  _buildPaymentTypeDropdown(state, notifier),
                  SizedBox(height: 16),
                  
                  // Calculate Button
                  ElevatedButton.icon(
                    onPressed: () => notifier.calculateAmount(),
                    icon: Icon(Icons.calculate),
                    label: Text('Hitung Total'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColor.birutua,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Amount (Read-only)
                  TextFormField(
                    initialValue: state.calculatedAmount > 0 
                        ? 'Rp ${state.calculatedAmount.toStringAsFixed(0)}' 
                        : '',
                    decoration: InputDecoration(
                      labelText: 'Jumlah Bayar *',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 16),
                  
                  // Evidence Image (for transfer only)
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
                    SizedBox(height: 16),
                  ],
                  
                  // Section: Additional Data
                  _buildSectionTitle('Data Tambahan'),
                  SizedBox(height: 12),
                  
                  // University Dropdown
                  _buildUniversityDropdown(ref, state, notifier),
                  SizedBox(height: 16),
                  
                  // Location
                  TextFormField(
                    controller: state.locationController,
                    decoration: InputDecoration(
                      labelText: 'Lokasi *',
                      border: OutlineInputBorder(),
                      hintText: 'Jl. Sudirman No. 10, Jakarta',
                    ),
                    maxLines: 2,
                    validator: (value) => value == null || value.isEmpty 
                        ? 'Lokasi wajib diisi' 
                        : null,
                  ),
                  SizedBox(height: 16),
                  
                  // Note
                  TextFormField(
                    controller: state.noteController,
                    decoration: InputDecoration(
                      labelText: 'Catatan',
                      border: OutlineInputBorder(),
                      hintText: 'Mohon datang 15 menit lebih awal',
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  
                  // Error Message
                  if (state.errorMessage != null)
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.errorMessage!,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Submit Button
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          state.isSubmitting
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    final success = await notifier.submit();
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Booking berhasil ditambahkan')),
                      );
                      // Refresh booking list
                      ref.invalidate(bookingProvider());
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.hijauaccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Simpan Booking'),
                ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: MyColor.birutua,
      ),
    );
  }

  Widget _buildUserDropdown(WidgetRef ref, BookingFormState state, BookingForm notifier) {
    final userListState = ref.watch(userGetListProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pilih User *', style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        DropdownSearch<String>(
          items: (filter, loadProps) {
            if (filter.isNotEmpty) {
              ref.read(userGetListProvider.notifier).getListUsers(100, search: filter);
            }
            return (userListState.userData ?? [])
                .map((user) => user.id)
                .toList();
          },
          itemAsString: (userId) {
            final user = (userListState.userData ?? [])
                .firstWhere((u) => u.id == userId, orElse: () => throw Exception('User not found'));
            return '${user.name} (${user.email})';
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: userListState.isloading == true 
                  ? 'Memuat data user...' 
                  : 'Pilih user',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Cari user...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            itemBuilder: (context, userId, isSelected, isHighlighted) {
              try {
                final user = (userListState.userData ?? [])
                    .firstWhere((u) => u.id == userId);
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  selected: isSelected,
                );
              } catch (e) {
                return SizedBox.shrink();
              }
            },
          ),
          selectedItem: _selectedUserId,
          onChanged: userListState.isloading == true 
              ? null 
              : (value) {
                  setState(() {
                    _selectedUserId = value;
                  });
                  notifier.setSelectedUser(value);
                },
          validator: (value) => value == null ? 'User wajib dipilih' : null,
        ),
      ],
    );
  }

  Widget _buildPackageDropdown(WidgetRef ref, BookingFormState state, BookingForm notifier) {
    final packageState = ref.watch(getPackageDropdownProvider(1, 100));
    
    return packageState.when(
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Package *', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: state.selectedPackage?.id,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih package',
              ),
              items: data.packages
                  .map((pkg) => DropdownMenuItem(
                        value: pkg.id,
                        child: Text(pkg.title),
                      ))
                  .toList(),
              onChanged: (packageId) {
                if (packageId != null) {
                  final selectedPkg = data.packages.firstWhere((p) => p.id == packageId);
                  notifier.setPackage(selectedPkg);
                }
              },
              validator: (value) => value == null ? 'Package wajib dipilih' : null,
            ),
            if (state.isFetchingPackageDetail) ...[
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Memuat detail package...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('Error loading packages: $error'),
    );
  }

  Widget _buildAddonsDropdown(WidgetRef ref, BookingFormState state, BookingForm notifier) {
    final addonsState = ref.watch(getListAddonsProvider(1, 100));
    
    return addonsState.when(
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Addons', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            
            // Selected Addons
            if (state.selectedAddons.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.selectedAddons.map((addon) {
                  return Chip(
                    label: Text('${addon.title} - Rp ${addon.price}'),
                    deleteIcon: Icon(Icons.close, size: 18),
                    onDeleted: () => notifier.removeAddon(addon),
                  );
                }).toList(),
              ),
            SizedBox(height: 8),
            
            // Dropdown to add addon
            DropdownButtonFormField<Addon>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tambah addon',
              ),
              items: data.addons
                  .map((addon) => DropdownMenuItem(
                        value: addon,
                        child: Text('${addon.title} - Rp ${addon.price}'),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  if (state.selectedAddons.any((a) => a.id == value.id)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${value.title} sudah ditambahkan')),
                    );
                  } else {
                    notifier.addAddon(value);
                  }
                }
              },
            ),
          ],
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('Error loading addons: $error'),
    );
  }

  Widget _buildDatePicker(BuildContext context, BookingFormState state, BookingForm notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tanggal *', style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: state.selectedDate ?? DateTime.now().add(Duration(days: 1)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (date != null) {
              notifier.setDate(date);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.selectedDate != null
                      ? DateFormat('dd MMMM yyyy').format(state.selectedDate!)
                      : 'Pilih tanggal',
                  style: TextStyle(
                    color: state.selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
                Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotDropdown(BookingFormState state, BookingForm notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Waktu *', style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: state.selectedTimeSlot,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Pilih waktu',
          ),
          items: Constant.timeSlots
              .map((slot) => DropdownMenuItem(
                    value: slot,
                    child: Text(slot),
                  ))
              .toList(),
          onChanged: (value) => notifier.setTimeSlot(value),
          validator: (value) => value == null ? 'Waktu wajib dipilih' : null,
        ),
      ],
    );
  }

  Widget _buildPaymentMethodDropdown(BookingFormState state, BookingForm notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _buildPaymentTypeDropdown(BookingFormState state, BookingForm notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipe Pembayaran *', style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        DropdownButtonFormField<TransactionPayType>(
          value: state.selectedPaymentType,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Pilih tipe pembayaran',
          ),
          items: [
            DropdownMenuItem(
              value: TransactionPayType.dp,
              child: Text('DP (50%)'),
            ),
            DropdownMenuItem(
              value: TransactionPayType.lunas,
              child: Text('LUNAS'),
            ),
          ],
          onChanged: (value) => notifier.setPaymentType(value),
          validator: (value) => value == null ? 'Tipe pembayaran wajib dipilih' : null,
        ),
      ],
    );
  }

  Widget _buildUniversityDropdown(WidgetRef ref, BookingFormState state, BookingForm notifier) {
    final universityState = ref.watch(getUniversityDropdownProvider(1, 100));
    
    return universityState.when(
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Universitas *', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            DropdownSearch<University>(
              items: (filter, loadProps) {
                if (filter.isNotEmpty) {
                  ref.read(getUniversityDropdownProvider(1, 100, search: filter).notifier);
                }
                return data.universities;
              },
              itemAsString: (univ) => univ.name,
              compareFn: (item1, item2) => item1.id == item2.id,
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Pilih universitas',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Cari universitas...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                itemBuilder: (context, univ, isSelected, isHighlighted) {
                  return ListTile(
                    title: Text(univ.name),
                    selected: isSelected,
                  );
                },
              ),
              selectedItem: state.selectedUniversity,
              onChanged: (value) => notifier.setUniversity(value),
              validator: (value) => value == null ? 'Universitas wajib dipilih' : null,
            ),
          ],
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('Error loading universities: $error'),
    );
  }
}
