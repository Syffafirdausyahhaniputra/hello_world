import 'package:flutter/material.dart';
import 'package:hello_world/Controller/KompetensiController.dart';
import 'package:hello_world/Model/KompetensiModel.dart';

class KompetensiProdiPage extends StatefulWidget {
  const KompetensiProdiPage({super.key});

  @override
  _KompetensiProdiPageState createState() => _KompetensiProdiPageState();
}

class _KompetensiProdiPageState extends State<KompetensiProdiPage> {
  final KompetensiController _controller = KompetensiController();
  late Future<List<KompetensiProdi>> _kompetensiList;

  @override
  void initState() {
    super.initState();
    _kompetensiList = _controller.fetchKompetensiList();
  }

  void _showBidangModal(int prodiId) async {
    try {
      // Fetch data from controller
      final bidangList = await _controller.fetchBidangList(prodiId);

      // Show modal dialog
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Modal Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Detail Data Kompetensi Prodi',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Modal Body
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Informasi Alert
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          border: Border.all(color: Colors.blue.shade100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.info, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Berikut adalah detail data kompetensi prodi:',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Prodi Information
                      Table(
                        columnWidths: const {
                          0: const IntrinsicColumnWidth(),
                          1: const FlexColumnWidth(),
                        },
                        children: [
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Prodi:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                bidangList.first
                                    .bidangNama, // Assuming all items share the same Prodi name
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Bidang:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: bidangList
                                    .map((bidang) =>
                                        Text('- ${bidang.bidangNama}'))
                                    .toList(),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),

                // Modal Footer
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      // Error handling
      print("kenapa gabisa pencet detail $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil detail bidang')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kompetensi Prodi'),
      ),
      body: FutureBuilder<List<KompetensiProdi>>(
        future: _kompetensiList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final kompetensiList = snapshot.data!;
          return ListView.builder(
            itemCount: kompetensiList.length,
            itemBuilder: (context, index) {
              final kompetensi = kompetensiList[index];
              return Card(
                child: ListTile(
                  title: Text(kompetensi.prodiNama),
                  subtitle: Text('Total Bidang: ${kompetensi.totalBidang}'),
                  trailing: const Icon(Icons.info, color: Colors.blue),
                  onTap: () => _showBidangModal(kompetensi.prodiId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
