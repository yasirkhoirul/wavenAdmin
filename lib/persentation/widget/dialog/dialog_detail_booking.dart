import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wavenadmin/common/color.dart';
import 'package:wavenadmin/persentation/widget/dialog/item_detail_dialog.dart';

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
                              ],
                              initialValue: '',
                              onChanged: (value) {},
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
                          sub: DropDownOutlined(
                            items: [],
                            initialValue: '',
                            onChanged: (value) {},
                          ),
                        ),
                        ItemDetail(
                          judul: 'Package',
                          sub: DropDownOutlined(
                            items: [],
                            initialValue: '',
                            onChanged: (value) {},
                          ),
                        ),
                        ItemDetail(
                          judul: 'Waktu Foto',
                          sub: DropDownOutlined(
                            items: [],
                            initialValue: '',
                            onChanged: (value) {},
                          ),
                        ),
                        ItemDetail(
                          judul: 'Extra',
                          sub: DropDownOutlined(
                            items: [],
                            initialValue: '',
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ItemDetail(
                          judul: 'Lokasi Foto',
                          sub: DropDownOutlined(
                            items: [],
                            initialValue: '',
                            onChanged: (value) {},
                          ),
                        ),
                        ItemDetail(
                          judul: 'Fotografer',
                          sub: DropDownOutlined(
                            items: [],
                            initialValue: '',
                            onChanged: (value) {},
                          ),
                        ),
                        ItemDetail(
                          judul: 'Status Foto',
                          sub: DropDownOutlined(
                            items: [],
                            initialValue: '',
                            onChanged: (value) {},
                          ),
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

