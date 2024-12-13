import 'package:flutter/material.dart';
import 'package:hello_world/Model/KompetensiModel.dart';
import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/Controller/BidangController.dart';


class deskripsiKompetensi extends StatelessWidget {
  final String prodiNama;
  final List<BidangModel> bidangList;

  const deskripsiKompetensi({super.key, required this.prodiNama, required this.bidangList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Detail Data Kompetensi Prodi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
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
              padding: const EdgeInsets.all(16),
              color: Colors.blue[50],
              child: const Row(
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
            const SizedBox(height: 16),
            Table(
              columnWidths: const {
                0: const FixedColumnWidth(100), // Lebar kolom pertama
                1: const FlexColumnWidth(),    // Lebar kolom kedua fleksibel
              },
              border: TableBorder.all(color: Colors.grey.shade300),
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Prodi:', textAlign: TextAlign.right),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(prodiNama),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Bidang:', textAlign: TextAlign.right),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
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
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
