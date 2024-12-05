import 'package:flutter/material.dart';
import 'package:hello_world/Model/KompetensiModel.dart';
import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/Controller/BidangController.dart';


class deskripsiKompetensi extends StatelessWidget {
  final String prodiNama;
  final List<BidangModel> bidangList;

  deskripsiKompetensi({required this.prodiNama, required this.bidangList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Detail Data Kompetensi Prodi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context); // Menutup modal
            },
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue[50],
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Informasi! Berikut adalah detail data kompetensi prodi:',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Table(
              columnWidths: {
                0: FixedColumnWidth(100), // Lebar kolom pertama
                1: FlexColumnWidth(),    // Lebar kolom kedua fleksibel
              },
              border: TableBorder.all(color: Colors.grey.shade300),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Prodi:', textAlign: TextAlign.right),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(prodiNama),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Bidang:', textAlign: TextAlign.right),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: bidangList.map((bidang) {
                          return Text('- ${bidang.bidangNama ?? '-'}');
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Menutup modal
          },
          child: Text('Tutup'),
        ),
      ],
    );
  }
}
