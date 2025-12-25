import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/get_university_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/university/university_detail_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';

class UniversityFormDialog extends ConsumerStatefulWidget {
  final String universityId;
  const UniversityFormDialog({super.key, required this.universityId});

  @override
  ConsumerState<UniversityFormDialog> createState() =>
      _UniversityFormDialogState();
}

class _UniversityFormDialogState extends ConsumerState<UniversityFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController briefNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String _statusValue = Status.aktif.name;
  bool _seededFromApi = false;

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  void _seedFromDetailOnce(UniversityDetail detail) {
    if (_seededFromApi) return;
    _seededFromApi = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      nameController.text = detail.name;
      briefNameController.text = detail.briefName;
      addressController.text = detail.address;

      setState(() {
        _statusValue =
            detail.isActive ? Status.aktif.name : Status.tidakaktif.name;
      });
    });
  }

  Widget _buildFormFields(UniversityDetail? detail) {
    if (detail != null) {
      _seedFromDetailOnce(detail);
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: Column(
              spacing: 10,
              children: [
                ItemDetailInputOutline(
                  judul: 'Nama Universitas',
                  controller: nameController,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'Singkatan',
                  controller: briefNameController,
                  validator: _requiredValidator,
                ),
                ItemDetail(
                  judul: "Status",
                  sub: DropDownOutlined(
                    items: const [
                      DropdownMenuItem(
                        value: 'aktif',
                        child: Text('Aktif'),
                      ),
                      DropdownMenuItem(
                        value: 'tidakaktif',
                        child: Text('Tidak Aktif'),
                      ),
                    ],
                    initialValue: _statusValue,
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Tidak boleh kosong';
                      }
                        
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _statusValue = value ?? Status.aktif.name;
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Alamat',
                      style: GoogleFonts.robotoFlex(
                        color: Color(0xFFE0E0E0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: addressController,
                      validator: _requiredValidator,
                      maxLines: 3,
                      style: GoogleFonts.robotoFlex(
                        color: MyColor.hijauaccent,
                        fontWeight: FontWeight.w200,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: MyColor.hijauaccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: MyColor.hijauaccent, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    briefNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final universityDetailAsync =
        ref.watch(universityDetailProvider(widget.universityId));

    return Card(
      color: MyColor.abuDialog,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 450,
          width: 700,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Detail Universitas",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: universityDetailAsync.when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (e, _) => Center(
                        child: Text(
                          'Error: $e',
                          style: GoogleFonts.robotoFlex(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      data: (detail) => _buildFormFields(detail),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 80,
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MButtonWeb(
                          ontap: () async {
                            final isValid =
                                _formKey.currentState?.validate() ?? false;
                            if (!isValid) return;

                            try {
                              await ref
                                  .read(
                                    universityDetailProvider(
                                      widget.universityId,
                                    ).notifier,
                                  )
                                  .updateUniversity(
                                    name: nameController.text.trim(),
                                    briefName: briefNameController.text.trim(),
                                    address: addressController.text.trim(),
                                    isActive: _statusValue == Status.aktif.name,
                                  );

                              if (context.mounted) {
                                // Invalidate list to refresh
                                ref.invalidate(getUniversityListProvider);
                                
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Data berhasil disimpan'),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Terjadi Kesalahan: $e"),
                                ),
                              );
                            }
                          },
                          teks: "Simpan",
                          icon: Icons.save_alt,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
