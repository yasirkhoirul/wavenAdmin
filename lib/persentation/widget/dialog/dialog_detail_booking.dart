import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';

class DialogDetailBooking extends StatelessWidget {
  const DialogDetailBooking({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColor.abucontainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Text("Detail Booking"),
            Divider(),
            Text("Detail Client"),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                spacing: 10,

                children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ItemDetail(
                            judul: 'ID booking',
                            sub: Text(
                              "#213131312112",
                              style: GoogleFonts.robotoFlex(
                                color: MyColor.abuinactivetulisan,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                          ItemDetail(
                            judul: 'Nama Client',
                            sub: DropDownOutlined(
                              items: const [
                                DropdownMenuItem(
                                  value: 'Personal 1',
                                  child: Text('Personal 1'),
                                ),
                                DropdownMenuItem(
                                  value: 'Personal 2',
                                  child: Text('Personal 2'),
                                ),
                                DropdownMenuItem(
                                  value: 'Personal 3',
                                  child: Text('Personal 3'),
                                ),
                              ], initialValue: '', onChanged: (value) {  },
                            ),
                          ),
                          ItemDetail(
                            judul: 'Email',
                            sub: Text("fshidiqi@gmail.com"),
                          ),
                          ItemDetail(
                            judul: 'No Hp',
                            sub: Text("6285226491722"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ItemDetail(
                          judul: 'Universitas',
                          sub: DropDownOutlined(items: [], initialValue: '', onChanged: (value) {  },),
                        ),
                        ItemDetail(judul: 'Package', sub: DropDownOutlined(items: [], initialValue: '', onChanged: (value) {  },)),
                        ItemDetail(
                          judul: 'Waktu Foto',
                          sub: DropDownOutlined(items: [], initialValue: '', onChanged: (value) {  },),
                        ),
                        ItemDetail(judul: 'Extra', sub: DropDownOutlined(items: [], initialValue: '', onChanged: (value) {  },)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ItemDetail(
                          judul: 'Lokasi Foto',
                          sub: DropDownOutlined(items: [], initialValue: '', onChanged: (value) {  },),
                        ),
                        ItemDetail(
                          judul: 'Fotografer',
                          sub: DropDownOutlined(items: [], initialValue: '', onChanged: (value) {  },),
                        ),
                        ItemDetail(
                          judul: 'Status Foto',
                          sub: DropDownOutlined(items: [], initialValue: '', onChanged: (value) {  },),
                        ),
                        ItemDetail(
                          judul: 'Verifikasi',
                          sub: Text("Belum Verifikasi"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Text("Detail Pembayaran"),
            Expanded(child: Padding(padding: EdgeInsets.all(8))),
            Divider(),
            Text("File Management"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Column(children: [Text("List Edited Foto")]),
                  ],
                ),
              ),
            ),
            Divider(),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("verifikasi")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownOutlined extends StatelessWidget {
  final String initialValue;
  final ValueChanged onChanged;
  final List<DropdownMenuItem<String>> items;
  const DropDownOutlined({super.key, required this.items, required this.initialValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColor.abudalamcontainer),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColor.hijauaccent),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}

class ItemDetail extends StatelessWidget {
  final String judul;
  final Widget sub;
  const ItemDetail({super.key, required this.judul, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          judul,
          style: GoogleFonts.robotoFlex(
            color: Color(0xFFE0E0E0),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Container(padding: const EdgeInsets.all(2), child: sub),
      ],
    );
  }
}

class ItemDetailOutline extends StatelessWidget {
  final String judul;
  final Widget sub;
  const ItemDetailOutline({super.key, required this.judul, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          judul,
          style: GoogleFonts.robotoFlex(
            color: Color(0xFFE0E0E0),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: MyColor.abudalamcontainer),
            borderRadius: BorderRadius.circular(8),
          ),
          child: sub,
        ),
      ],
    );
  }
}
