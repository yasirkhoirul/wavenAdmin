import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/update_booking_request_model.dart';
import 'package:wavenadmin/domain/entity/detail_booking.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';
import 'package:wavenadmin/domain/entity/photographer_dropdown.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/addons/get_list_addons_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/update_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/upload_photo_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/verify_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/verify_transaction_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/package/get_package_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/get_photographer_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/get_university_dropdown_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/dropdown_detail_booking.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';

class DialogDetailBooking extends ConsumerStatefulWidget {
  final String idBooking;
  const DialogDetailBooking({super.key, required this.idBooking});

  @override
  ConsumerState<DialogDetailBooking> createState() =>
      _DialogDetailBookingState();
}

class _DialogDetailBookingState extends ConsumerState<DialogDetailBooking> {
  final namaClient = TextEditingController();
  final noHp = TextEditingController();
  final uploadOri = TextEditingController();
  final uploadEdit = TextEditingController();
  University? selectedUniversityId;
  Package? selectedPackageId;
  String? eventDate;
  String? eventStartTime;
  String? eventEndTime;
  String? locationAddress;
  bool alreadyPhoto = false;
  List<Addon> selectedAddonIds = [];
  List<PhotographerDropdownItem> selectedPhotographers = [];

  @override
  void dispose() {
    namaClient.dispose();
    uploadOri.dispose();
    uploadEdit.dispose();
    noHp.dispose();
    super.dispose();
  }

  void _initializeData(DetailBooking data) {
    // Initialize controllers
    namaClient.text = data.clientName;
    noHp.text = data.clientPhoneNumber;
    uploadOri.text = data.photoResultUrl;
    uploadEdit.text = data.editedPhotoResultUrl;
    selectedUniversityId = University(
      id: data.universityId,
      name: data.university,
    );
    selectedPackageId = Package(id: data.packageId, title: data.packageName);
    eventDate = data.eventDate;
    eventStartTime = data.eventStartTime;
    eventEndTime = data.eventEndTime;
    locationAddress = data.location;
    alreadyPhoto = data.alreadyPhoto;
    selectedAddonIds = data.extra
        .map((e) => Addon(id: e.id, title: e.name))
        .toList();
    selectedPhotographers = data.photographerData
        .map(
          (e) => PhotographerDropdownItem(
            id: e.id,
            feePerHour: e.fee,
            name: e.name,
          ),
        )
        .toList();
  }

  Future<void> _handleSave() async {
    // Validasi semua field required
    if (selectedUniversityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pilih universitas terlebih dahulu')),
      );
      return;
    }

    if (selectedPackageId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pilih package terlebih dahulu')),
      );
      return;
    }

    if (eventDate == null || eventStartTime == null || eventEndTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lengkapi data waktu event')),
      );
      return;
    }

    if (locationAddress == null || locationAddress!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Isi alamat lokasi terlebih dahulu')),
      );
      return;
    }

    // Build request
    final request = UpdateBookingRequest(
      universityId: selectedUniversityId!.id,
      packageId: selectedPackageId!.id,
      eventDate: eventDate!,
      eventStartTime: eventStartTime!,
      eventEndTime: eventEndTime!,
      locationAddress: locationAddress!,
      alreadyPhoto: alreadyPhoto,
      addonIds: selectedAddonIds.map((addon) => addon.id).toList(),
      photographers: selectedPhotographers
          .map((p) => PhotographerRequest(id: p.id, fee: p.feePerHour))
          .toList(),
    );
    ref.read(updateBookingProvider.notifier).execute(widget.idBooking, request);

  }

  Future<void> _handleVerify(VerifyStatus status, {String? remarks}) async {
    final notifier = ref.read(verifyBookingProvider.notifier);
    await notifier.execute(widget.idBooking, status, remarks: remarks);
    
    final state = ref.read(verifyBookingProvider);
    if (!mounted) return;
    
    state.when(
      data: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        Navigator.pop(context);
      },
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
      loading: () {},
    );
  }

  Future<void> _showRejectDialog() async {
    final remarksController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text('Alasan Penolakan'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: remarksController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Masukkan alasan penolakan...',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Alasan penolakan wajib diisi';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final remarks = remarksController.text.trim();
                Navigator.of(dialogContext).pop(remarks);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: Text('Tolak'),
          ),
        ],
      ),
    );

    // Dispose controller dengan aman
    await Future.delayed(Duration.zero);
    remarksController.dispose();
    
    // Proses verifikasi jika ada remarks
    if (result != null && result.isNotEmpty && mounted) {
      await _handleVerify(VerifyStatus.rejected, remarks: result);
    }
  }

  Future<void> _handleUploadPhotoResult() async {
    if (uploadOri.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('URL foto original tidak boleh kosong')),
      );
      return;
    }

    final notifier = ref.read(uploadPhotoResultProvider.notifier);
    await notifier.execute(widget.idBooking, uploadOri.text.trim());

    final state = ref.read(uploadPhotoResultProvider);
    if (!mounted) return;

    state.when(
      data: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
      loading: () {},
    );
  }

  Future<void> _handleUploadEditedPhoto() async {
    if (uploadEdit.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('URL foto edited tidak boleh kosong')),
      );
      return;
    }

    final notifier = ref.read(uploadEditedPhotoProvider.notifier);
    await notifier.execute(widget.idBooking, uploadEdit.text.trim());

    final state = ref.read(uploadEditedPhotoProvider);
    if (!mounted) return;

    state.when(
      data: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
      loading: () {},
    );
  }

  Future<void> _handleVerifyTransaction(String transactionId) async {
    final notifier = ref.read(verifyTransactionProvider.notifier);
    await notifier.execute(widget.idBooking, transactionId, VerifyStatus.approved);
    
    final state = ref.read(verifyTransactionProvider);
    if (!mounted) return;
    
    state.when(
      data: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
      loading: () {},
    );
  }

  Future<void> _showRejectTransactionDialog(String transactionId) async {
    final remarksController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text('Alasan Penolakan Transaksi'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: remarksController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Masukkan alasan penolakan transaksi...',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Alasan penolakan wajib diisi';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final remarks = remarksController.text.trim();
                Navigator.of(dialogContext).pop(remarks);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: Text('Tolak'),
          ),
        ],
      ),
    );

    // Dispose controller dengan aman
    await Future.delayed(Duration.zero);
    remarksController.dispose();
    
    // Proses penolakan jika ada remarks
    if (result != null && result.isNotEmpty && mounted) {
      final notifier = ref.read(verifyTransactionProvider.notifier);
      await notifier.execute(widget.idBooking, transactionId, VerifyStatus.rejected, remarks: result);
      
      final state = ref.read(verifyTransactionProvider);
      if (!mounted) return;
      
      state.when(
        data: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        },
        loading: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailBookingProvider(widget.idBooking));
    final stateupdate = ref.watch(updateBookingProvider);
    final stateVerify = ref.watch(verifyBookingProvider);
    final stateUploadOri = ref.watch(uploadPhotoResultProvider);
    final stateUploadEdit = ref.watch(uploadEditedPhotoProvider);
    final stateAddons = ref.watch(getListAddonsProvider(1, 100, search: ''));
    final stateFotografer = ref.watch(
      getPhotographerDropdownProvider(1, 100, search: ''),
    );
    final stateUniversitas = ref.watch(
      getUniversityDropdownProvider(1, 100, search: ''),
    );
    final statePackage = ref.watch(
      getPackageDropdownProvider(1, 100, search: ''),
    );

    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 700;

    return SizedBox(
      width: 1000,
      height: 800,
      child: Center(
        child: Card(
          color: MyColor.abucontainer,
          child: state.when(
            error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
            loading: () {
              return Center(child: CircularProgressIndicator());
            },
            data: (data) {
              // Initialize data saat pertama kali load
              if (namaClient.text.isEmpty) {
                _initializeData(data);
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text("Detail Booking"),
                      Divider(),
                      Text("Detail Client"),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: isSmallScreen
                            ? Column(
                                spacing: 10,
                                children: [
                                  Column(
                                    spacing: 10,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ItemDetail(
                                        judul: 'ID booking',
                                        sub: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: ItemDetailText(textSub: data.id)),
                                      ),
                                      ItemDetailInputOutline(
                                        judul: "Nama Client",
                                        controller: namaClient,
                                      ),
                                      ItemDetail(
                                        judul: 'Email',
                                        sub: ItemDetailText(
                                          textSub: data.clientInstagram,
                                        ),
                                      ),
                                      ItemDetailInputOutlineGreenText(
                                        judul: "No Hp",
                                        controller: noHp,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    spacing: 10,
                                    children: [
                                      // TODO: Fetch universitas list from API
                                      // Display: university name, Value: {id, fee} Map
                                      DropDownUniv(
                                        stateUniversitas: stateUniversitas,
                                        selectedUniv: selectedUniversityId,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedUniversityId = value;
                                          });
                                        },
                                      ),
                                      // TODO: Fetch package list from API
                                      // Display: package name, Value: {id, fee} Map
                                      DropdownPackage(
                                        statePackage: statePackage,
                                        selectedPackage: selectedPackageId,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedPackageId = value;
                                          });
                                        },
                                      ),
                                      ItemDetail(
                                        judul: 'Waktu Foto',
                                        sub: ItemDetailText(
                                          textSub:
                                              '${data.eventStartTime} - ${data.eventEndTime}',
                                        ),
                                      ),
                                      DropDownAddons(
                                        stateAddons: stateAddons,
                                        selectedAddonIds: selectedAddonIds,
                                        onValues: (addons) {
                                          setState(() {
                                            selectedAddonIds.remove(addons);
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            final isExist = selectedAddonIds
                                                .any(
                                                  (addon) =>
                                                      addon.id == value!.id,
                                                );

                                            if (!isExist) {
                                              selectedAddonIds.add(value!);
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '${value!.title} sudah ditambahkan',
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    spacing: 10,
                                    children: [
                                      ItemDetail(
                                        judul: 'Lokasi Foto',
                                        sub: ItemDetailText(
                                          textSub: data.location,
                                        ),
                                      ),
                                      // TODO: Fetch photographer list from API
                                      // Display: photographer name, Value: List<Map> with {id, fee}
                                      DropDownFotografer(
                                        stateFotografer: stateFotografer,
                                        selectedPhotographers:
                                            selectedPhotographers,
                                        onValues: (item) {
                                          setState(() {
                                            selectedPhotographers.remove(item);
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            final isExist =
                                                selectedPhotographers.any(
                                                  (addon) =>
                                                      addon.id == value!.id,
                                                );

                                            if (!isExist) {
                                              selectedPhotographers.add(value!);
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '${value!.name} sudah ditambahkan',
                                                  ),
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                      ),
                                      ItemDetail(
                                        judul: 'Status Foto',
                                        sub: DropDownOutlined(
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'true',
                                              child: Text('Sudah Foto'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'false',
                                              child: Text('Belum Foto'),
                                            ),
                                          ],
                                          initialValue: alreadyPhoto.toString(),
                                          onChanged: (value) {
                                            setState(() {
                                              alreadyPhoto = value == 'true';
                                            });
                                          },
                                        ),
                                      ),
                                      ItemDetail(
                                        judul: 'Verifikasi',
                                        sub: ItemDetailText(
                                          textSub: data.verificationStatus,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 10,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ItemDetail(
                                          judul: 'ID booking',
                                          sub: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: ItemDetailText(textSub: data.id)),
                                        ),
                                        ItemDetailInputOutline(
                                          judul: "Nama Client",
                                          controller: namaClient,
                                        ),
                                        ItemDetail(
                                          judul: 'Email',
                                          sub: ItemDetailText(
                                            textSub: data.clientInstagram,
                                          ),
                                        ),
                                        ItemDetailInputOutlineGreenText(
                                          judul: "No Hp",
                                          controller: noHp,
                                        ),
                                        ItemDetail(
                                          judul: 'Status Foto',
                                          sub: DropDownOutlined(
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'true',
                                                child: Text('Sudah Foto'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'false',
                                                child: Text('Belum Foto'),
                                              ),
                                            ],
                                            initialValue: alreadyPhoto
                                                .toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                alreadyPhoto = value == 'true';
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 10,
                                      children: [
                                        DropDownUniv(
                                          stateUniversitas: stateUniversitas,
                                          selectedUniv: selectedUniversityId,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedUniversityId = value;
                                            });
                                          },
                                        ),
                                        // TODO: Fetch package list from API
                                        // Display: package name, Value: {id, fee} Map
                                        DropdownPackage(
                                          statePackage: statePackage,
                                          selectedPackage: selectedPackageId,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedPackageId = value;
                                            });
                                          },
                                        ),
                                        ItemDetail(
                                          judul: 'Waktu Foto',
                                          sub: ItemDetailText(
                                            textSub:
                                                '${data.eventStartTime} - ${data.eventEndTime}',
                                          ),
                                        ),
                                        ItemDetail(
                                          judul: 'Lokasi Foto',
                                          sub: ItemDetailText(
                                            textSub: data.location,
                                          ),
                                        ),
                                        ItemDetail(
                                          judul: 'Verifikasi',
                                          sub: ItemDetailText(
                                            textSub: data.verificationStatus,
                                          ),
                                        ),

                                        // TODO: Fetch addon/extra list from API
                                        
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 10,
                                      children: [
                                        DropDownAddons(
                                          stateAddons: stateAddons,
                                          selectedAddonIds: selectedAddonIds,
                                          onValues: (addons) {
                                            setState(() {
                                              selectedAddonIds.remove(addons);
                                            });
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              final isExist = selectedAddonIds
                                                  .any(
                                                    (addon) =>
                                                        addon.id == value!.id,
                                                  );

                                              if (!isExist) {
                                                selectedAddonIds.add(value!);
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${value!.title} sudah ditambahkan',
                                                    ),
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                        ),
                                        DropDownFotografer(
                                          stateFotografer: stateFotografer,
                                          selectedPhotographers:
                                              selectedPhotographers,
                                          onValues: (item) {
                                            setState(() {
                                              selectedPhotographers.remove(
                                                item,
                                              );
                                            });
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              final isExist =
                                                  selectedPhotographers.any(
                                                    (addon) =>
                                                        addon.id == value!.id,
                                                  );

                                              if (!isExist) {
                                                selectedPhotographers.add(
                                                  value!,
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${value!.name} sudah ditambahkan',
                                                    ),
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                        ),
                                        
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          stateupdate.when(data: (data) => Expanded(
                            child:!isSmallScreen? LButtonWeb(
                              ontap: _handleSave,
                              teks: "Simpan",
                              icon: Icons.save_alt_rounded,
                            ):LBUttonMobile(ontap: _handleSave,
                              teks: "Simpan",
                              icon: Icons.save_alt_rounded,),
                          ), error: (error, stackTrace) => Text("gagal memperbarui detail : $error"), loading: () => Center(child: CircularProgressIndicator(),),)
                        ],
                      ),
                      Divider(),
                      Text("Detail Pembayaran"),

                      LayoutBuilder(
                        builder: (context,constrains) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 800,
                                maxWidth: constrains.maxWidth<800?800:constrains.maxWidth
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ItemDetail(
                                      judul: "Jumlah Bayar",
                                      sub: ItemDetailText(
                                        textSub: "Rp ${data.totalAmount}",
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ItemDetail(
                                      judul: "Sudah Bayar",
                                      sub: ItemDetailText(
                                        textSub: "Rp ${data.paidAmount}",
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ItemDetail(
                                      judul: "Kurang Bayar",
                                      sub: ItemDetailText(
                                        textSub: "Rp ${data.unpaidAmount}",
                                      ),
                                    ),
                                  ),
                                 
                                  Flexible(
                                    child: ItemDetail(
                                      judul: "Status Booking",
                                      sub: DropDownOutlined(
                                        items: StatusBooking.values
                                            .map(
                                              (e) => DropdownMenuItem<String>(
                                                value: e.name,
                                                child: Text(e.name),
                                              ),
                                            )
                                            .toList(),
                                        initialValue: data.status,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                      Divider(),
                      Text("Detail Transaksi"),
                      SizedBox(
                        height: 300,
                        child: data.transactions.isEmpty
                            ? Center(
                                child: Text(
                                  "Transaksi belum ada",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: data.transactions.length,
                                itemBuilder: (context, index) {
                                  final transaction = data.transactions[index];
                                  final isTransfer = transaction.method.toUpperCase() == "TRANSFER";
                                  
                                  return Card(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "Rp ${transaction.amount}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Metode: ${transaction.method}"),
                                          Text("Type: ${transaction.type}"),
                                          Text("Waktu: ${transaction.transactionTime}"),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              // Tombol verifikasi dan tolak hanya muncul saat status PENDING
                                              if (transaction.status.toUpperCase() == VerificationStatus.PENDING.name && data.status.toString() == StatusBooking.PENDING.name) ...[
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    _handleVerifyTransaction(transaction.id);
                                                  },
                                                  icon: Icon(Icons.check_circle, size: 16),
                                                  label: Text("Verifikasi"),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: MyColor.hijauaccent,
                                                    foregroundColor: Colors.white,
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    _showRejectTransactionDialog(transaction.id);
                                                  },
                                                  icon: Icon(Icons.cancel, size: 16),
                                                  label: Text("Tolak"),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.redAccent,
                                                    foregroundColor: Colors.white,
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              if (isTransfer && transaction.transactionEvidenceUrl != null && transaction.transactionEvidenceUrl!.isNotEmpty) ...[
                                                SizedBox(width: 8),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) => Dialog(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.all(16),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Bukti Transfer",
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    icon: Icon(Icons.close),
                                                                    onPressed: () => Navigator.pop(context),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: InteractiveViewer(
                                                                child: Image.network(
                                                                  transaction.transactionEvidenceUrl!,
                                                                  fit: BoxFit.contain,
                                                                  errorBuilder: (context, error, stackTrace) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.all(16),
                                                                      child: Text(
                                                                        "Gagal memuat gambar",
                                                                        style: TextStyle(color: Colors.red),
                                                                      ),
                                                                    );
                                                                  },
                                                                  loadingBuilder: (context, child, loadingProgress) {
                                                                    if (loadingProgress == null) return child;
                                                                    return Center(
                                                                      child: CircularProgressIndicator(
                                                                        value: loadingProgress.expectedTotalBytes != null
                                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                                loadingProgress.expectedTotalBytes!
                                                                            : null,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 16),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.image, size: 16),
                                                  label: Text("Lihat Bukti"),
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: MyColor.birutua,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            transaction.status,
                                            style: TextStyle(
                                              color: transaction.status ==
                                                      "success"
                                                  ? MyColor.hijauaccent
                                                  : MyColor.oren,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            transaction.verificationStatus,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Divider(),
                      Text("File Management"),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          height: isSmallScreen ? 400 : 100,
                          child: isSmallScreen
                              ? Column(
                                  spacing: 10,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Column(
                                      spacing: 10,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("List Edit Foto"),
                                        Column(
                                          spacing: 10,
                                          children: [
                                            LBUttonMobile(
                                              ontap: () {},
                                              teks: "Lihat List Edit",
                                            ),
                                            LBUttonMobile(
                                              ontap: () {},
                                              teks: "Copy",
                                              color: MyColor.birutua,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("File Uploaded"),
                                          Column(
                                            spacing: 10,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ItemDetailInputOutline(
                                                judul: "Ori",
                                                controller: uploadOri,
                                              ),
                                              stateUploadOri.isLoading
                                                  ? CircularProgressIndicator()
                                                  : LBUttonMobile(
                                                      ontap: _handleUploadPhotoResult,
                                                      teks: "Upload",
                                                    ),
                                              ItemDetailInputOutline(
                                                judul: "Edited",
                                                controller: uploadEdit,
                                              ),
                                              stateUploadEdit.isLoading
                                                  ? CircularProgressIndicator()
                                                  : LBUttonMobile(
                                                      ontap: _handleUploadEditedPhoto,
                                                      teks: "Upload",
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  spacing: 10,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,

                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("List Edit Foto"),
                                        Row(
                                          spacing: 10,
                                          children: [
                                            LButtonWeb(
                                              ontap: () {},
                                              teks: "Lihat List Edit",
                                            ),
                                            LButtonWeb(
                                              ontap: () {},
                                              teks: "Copy",
                                              color: MyColor.birutua,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("File Uploaded"),
                                          Row(
                                            spacing: 10,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: ItemDetailInputOutline(
                                                  judul: "Ori",
                                                  controller: uploadOri,
                                                ),
                                              ),
                                              stateUploadOri.isLoading
                                                  ? CircularProgressIndicator()
                                                  : LButtonWeb(
                                                      ontap: _handleUploadPhotoResult,
                                                      teks: "Upload",
                                                    ),
                                              Expanded(
                                                child: ItemDetailInputOutline(
                                                  judul: "Edited",
                                                  controller: uploadEdit,
                                                ),
                                              ),
                                              stateUploadEdit.isLoading
                                                  ? CircularProgressIndicator()
                                                  : LButtonWeb(
                                                      ontap: _handleUploadEditedPhoto,
                                                      teks: "Upload",
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Divider(),
                      isSmallScreen
                          ? Column(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LBUttonMobile(
                                  ontap: () {
                                    Navigator.pop(context);
                                  },
                                  teks: "Batal",
                                  color: MyColor.oren,
                                ),
                                stateVerify.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : LBUttonMobile(
                                        ontap: _showRejectDialog,
                                        teks: "Tolak",
                                        color: Colors.redAccent,
                                      ),
                                stateVerify.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : LBUttonMobile(
                                        ontap: () => _handleVerify(VerifyStatus.approved),
                                        teks: "Verifikasi",
                                        color: MyColor.hijauaccent,
                                      ),
                              ],
                            )
                          : Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LButtonWeb(
                                  ontap: () {
                                    Navigator.pop(context);
                                  },
                                  teks: "Batal",
                                  color: MyColor.oren,
                                ),
                                stateVerify.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : LButtonWeb(
                                        ontap: _showRejectDialog,
                                        teks: "Tolak",
                                        color: Colors.redAccent,
                                      ),
                                stateVerify.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : LButtonWeb(
                                        ontap: () => _handleVerify(VerifyStatus.approved),
                                        teks: "Verifikasi",
                                        color: MyColor.hijauaccent,
                                      ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

