import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/create_fotografer.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/photographer_list.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';

class DialogTambahFotografer extends ConsumerStatefulWidget {
  const DialogTambahFotografer({super.key});

  @override
  ConsumerState<DialogTambahFotografer> createState() =>
      _DialogTambahFotograferState();
}

class _DialogTambahFotograferState
    extends ConsumerState<DialogTambahFotografer> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController gearsController = TextEditingController();
  final TextEditingController feePerHourController = TextEditingController();

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  String? _numberValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    if (int.tryParse(value) == null) return 'Harus berupa angka';
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    if (!value.contains('@')) return 'Format email tidak valid';
    return null;
  }

  Widget _buildFormFields() {
    final width = MediaQuery.of(context).size.width;

    // Use column layout for small screens (<700), otherwise keep the 3-column row
    if (width < 700) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ItemDetailInputOutline(
              judul: 'Username',
              controller: usernameController,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutline(
              judul: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _emailValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutline(
              judul: 'Nama Fotografer',
              controller: nameController,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutlineGreenText(
              judul: 'No Hp',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutlineGreenText(
              judul: 'Password',
              controller: passwordController,

              validator: _requiredValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutline(
              judul: 'No Rekening',
              controller: accountNumberController,
              keyboardType: TextInputType.number,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutline(
              judul: 'Bank',
              controller: bankAccountController,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutline(
              judul: 'Peralatan',
              controller: gearsController,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 10),
            ItemDetailInputOutlineGreenText(
              judul: 'Tarif/Jam',
              controller: feePerHourController,
              keyboardType: TextInputType.number,
              validator: _numberValidator,
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Expanded(
            child: Column(
              spacing: 10,
              children: [
                ItemDetailInputOutline(
                  judul: 'Username',
                  controller: usernameController,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'Nama Fotografer',
                  controller: nameController,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutlineGreenText(
                  judul: 'No Hp',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: _requiredValidator,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              spacing: 10,
              children: [
                ItemDetailInputOutlineGreenText(
                  judul: 'Password',
                  controller: passwordController,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'No Rekening',
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'Bank',
                  controller: bankAccountController,
                  validator: _requiredValidator,
                ),
                ItemDetailInputOutline(
                  judul: 'Peralatan',
                  controller: gearsController,
                  validator: _requiredValidator,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                ItemDetailInputOutlineGreenText(
                  judul: 'Tarif/Jam',
                  controller: feePerHourController,
                  keyboardType: TextInputType.number,
                  validator: _numberValidator,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    accountNumberController.dispose();
    bankAccountController.dispose();
    gearsController.dispose();
    feePerHourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createState = ref.watch(createFotograferProvider);
    Logger().d(createState.requestState);

    return Center(
      child: Card(
        color: MyColor.abuDialog,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000,minHeight: 500),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Tambah Fotografer",
                            style: GoogleFonts.robotoFlex(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.cancel, color: Colors.white),
                        ),
                      ],
                    ),
                    createState.requestState == RequestState.loading
                      ?Center(child: CircularProgressIndicator(),)
                      :Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFormFields(),
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
                                      _formKey.currentState?.validate() ??
                                      false;
                                  if (!isValid) return;
                    
                                  try {
                                    // Create UserFotografer entity from input
                                    final fotografer = UserFotografer(
                                      id: '',
                                      name: nameController.text.trim(),
                                      phoneNumber: phoneController.text
                                          .trim(),
                                      accountNumber: accountNumberController
                                          .text
                                          .trim(),
                                      bankAccount: bankAccountController.text
                                          .trim(),
                                      feePerHour: int.parse(
                                        feePerHourController.text.trim(),
                                      ),
                                      gears: gearsController.text.trim(),
                                      instagram: '',
                                      location: '',
                                      isActive: true,
                                    );
                    
                                    // Call onInput to update the notifier state
                                    ref
                                        .read(
                                          createFotograferProvider.notifier,
                                        )
                                        .onInput(
                                          fotografer,
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          usernameController.text.trim(),
                                        );
                    
                                    // Call onSubmit to create the photographer
                                    final result = await ref
                                        .read(
                                          createFotograferProvider.notifier,
                                        )
                                        .onSubmit();
                    
                                    if (!context.mounted) return;
                    
                                    if (result.isNotEmpty) {
                                      ref.read(photographerListProvider.notifier).loadFirstPage();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            'Fotografer berhasil dibuat',
                                          ),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'Gagal membuat fotografer',
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (error) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(error.toString()),
                                      ),
                                    );
                                  }
                                },
                                teks: "Simpan",
                                icon: Icons.save_alt,
                              ),
                              MButtonWeb(
                                ontap: () {
                                  Navigator.of(context).pop();
                                },
                                teks: "Batal",
                                icon: Icons.close,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
