import 'package:flutter/material.dart';
import 'package:wavenadmin/common/icon.dart';
import 'package:wavenadmin/persentation/pages/schedule_page.dart';
import 'package:wavenadmin/persentation/widget/carditemcontainer.dart';
import 'package:wavenadmin/persentation/widget/dialog/dialog_detail_booking.dart';
import '../../../common/color.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          HeaderPage(judul: "Client", icon: MyIcon.iconmanajemenclien,),
          Row(
            children: [
              Expanded(
                child: CardItemContainer(
                  aset: MyIcon.iconusers,
                  judul: "Total Bookings",
                  content: "100",
                  color: MyColor.oren,
                  subcontent: "Clients",
                ),
              ),
              Expanded(
                child: CardItemContainer(
                  aset: MyIcon.icondompet,
                  judul: "Belum Lunas",
                  content: "100",
                  color: MyColor.birutua,
                  subcontent: "Clients",
                ),
              ),
              Expanded(
                child: CardItemContainer(
                  aset: MyIcon.icondompet,
                  judul: "Lunas",
                  content: "100",
                  color: MyColor.hijauaccent,
                  subcontent: "Clients",
                ),
              ),
              Expanded(
                child: CardItemContainer(
                  aset: MyIcon.iconcancel,
                  judul: "Perlu Verifikasi",
                  content: "100",
                  color: MyColor.oren,
                  subcontent: "Clients",
                ),
              ),
              Expanded(
                child: CardItemContainer(
                  aset: MyIcon.iconcheck,
                  judul: "Terverifikasi",
                  content: "100",
                  color: MyColor.hijauaccent,
                  subcontent: "Clients",
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Aksi')),
                DataColumn(label: Text('Nama Client')),
                DataColumn(label: Text('Universitas')),
                DataColumn(label: Text('Package')),
                DataColumn(label: Text('Tanggal Book')),
                DataColumn(label: Text('Waktu Book')),
                DataColumn(label: Text('Sudah Bayar')),
                DataColumn(label: Text('Status Bayar')),
                DataColumn(label: Text('Bukti TF')),
                DataColumn(label: Text('Verifikasi')),
                DataColumn(label: Text('Fotografer')),
                DataColumn(label: Text('Status Foto')),
                DataColumn(label: Text('Upload File')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('1')),
                    DataCell(
                      PopupMenuButton<String>(
                        borderRadius: BorderRadius.circular(14),
                        
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => ['a', 'b', 'c']
                            .map(
                              (e) => PopupMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onSelected: (String? value) {
                          if (value == 'a') {
                            print('a');
                          } else if (value == 'b') {
                            showDialog(context: context, builder:(context) => Center(child: SizedBox(
                              width: 800,
                              height: 800,
                              child: DialogDetailBooking()),),);
                          }
                        },
                      ),
                    ),
                    DataCell(Text('Anjana Yasa')),
                    DataCell(Text('UGM')),
                    DataCell(Text('Personal')),
                    DataCell(Text('21 September 2025')),
                    DataCell(Text('13.00-14.00')),
                    DataCell(Text('Rp 175.000')),
                    DataCell(_buildStatusChip('Pending')),
                    DataCell(Icon(Icons.description)),
                    DataCell(_buildStatusChip('Belum', color: Colors.orange)),
                    DataCell(
                      _buildStatusChip('Belum Assign', color: Colors.orange),
                    ),
                    DataCell(_buildStatusChip('Belum Foto')),
                    DataCell(_buildActionButton('Belum')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('2')),
                    DataCell(
                      PopupMenuButton<String>(
                        borderRadius: BorderRadius.circular(14),
                        
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => ['a', 'b', 'c']
                            .map(
                              (e) => PopupMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onSelected: (String? value) {
                          if (value == 'a') {
                            print('a');
                          } else if (value == 'b') {
                            print('b');
                          }
                        },
                      ),
                    ),
                    DataCell(Text('Anjana Yasa')),
                    DataCell(Text('UGM')),
                    DataCell(Text('Personal')),
                    DataCell(Text('21 September 2025')),
                    DataCell(Text('13.00-14.00')),
                    DataCell(Text('Rp 175.000')),
                    DataCell(
                      _buildStatusChip('Belum Lunas', color: Colors.cyan),
                    ),
                    DataCell(Icon(Icons.description)),
                    DataCell(_buildStatusChip('Belum', color: Colors.orange)),
                    DataCell(
                      _buildStatusChip('Belum Assign', color: Colors.orange),
                    ),
                    DataCell(_buildStatusChip('Belum Foto')),
                    DataCell(_buildActionButton('Belum')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('3')),
                    DataCell(
                      PopupMenuButton<String>(
                        borderRadius: BorderRadius.circular(14),
                        
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => ['a', 'b', 'c']
                            .map(
                              (e) => PopupMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onSelected: (String? value) {
                          if (value == 'a') {
                            print('a');
                          } else if (value == 'b') {
                            print('b');
                          }
                        },
                      ),
                    ),
                    DataCell(Text('Andu')),
                    DataCell(Text('UII')),
                    DataCell(Text('Personal 2')),
                    DataCell(Text('15 Oktober 2025')),
                    DataCell(Text('13.00-14.00')),
                    DataCell(Text('Rp 500.000')),
                    DataCell(
                      _buildStatusChip('Belum Lunas', color: Colors.cyan),
                    ),
                    DataCell(Icon(Icons.description)),
                    DataCell(_buildStatusChip('Belum', color: Colors.orange)),
                    DataCell(
                      _buildStatusChip('Belum Assign', color: Colors.orange),
                    ),
                    DataCell(_buildStatusChip('Belum Foto')),
                    DataCell(_buildActionButton('Belum')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('4')),
                    DataCell(
                      PopupMenuButton<String>(
                        borderRadius: BorderRadius.circular(14),
                        
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => ['a', 'b', 'c']
                            .map(
                              (e) => PopupMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onSelected: (String? value) {
                          if (value == 'a') {
                            print('a');
                          } else if (value == 'b') {
                            print('b');
                          }
                        },
                      ),
                    ),
                    DataCell(Text('Andu')),
                    DataCell(Text('UMY')),
                    DataCell(Text('Group')),
                    DataCell(Text('15 Oktober 2025')),
                    DataCell(Text('13.00-14.00')),
                    DataCell(Text('Rp 500.000')),
                    DataCell(
                      _buildStatusChip('Settlement', color: Colors.green),
                    ),
                    DataCell(Icon(Icons.description)),
                    DataCell(
                      _buildStatusChip('Terverifikasi', color: Colors.green),
                    ),
                    DataCell(_buildStatusChip('Fathi', color: Colors.cyan)),
                    DataCell(
                      _buildStatusChip('Sudah Foto', color: Colors.green),
                    ),
                    DataCell(_buildActionButton('Belum')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, {Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? MyColor.hijauaccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
