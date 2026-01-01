import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/pengaturan/pengaturan_notifier.dart';
import 'package:wavenadmin/persentation/widget/button.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';
import 'package:wavenadmin/persentation/widget/header_page.dart';

class PengaturanPage extends ConsumerStatefulWidget {
  const PengaturanPage({super.key});

  @override
  ConsumerState<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends ConsumerState<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pengaturanProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderPage(judul: "Pengaturan", icon: MyIcon.iconpengaturan),
          Padding(
            padding: const EdgeInsets.all(20),
            child: state.when(
              data: (data) {
                return Column(
                  children: [
                    ItemDetail(
                      judul: "Pembayaran Dengan Payment Gateway",
                      sub: Row(
                        children: [
                          Switch(
                            value: data.isActive,
                            onChanged: (value) async {
                              await ref
                                  .read(pengaturanProvider.notifier)
                                  .onChanged(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return Column(
                  children: [
                    Text("Terjadi Kesalahan $error"),
                    MButtonWeb(
                      ontap: () {
                        ref.invalidate(pengaturanProvider);
                      },
                      teks: "Coba Lagi",
                    ),
                  ],
                );
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
