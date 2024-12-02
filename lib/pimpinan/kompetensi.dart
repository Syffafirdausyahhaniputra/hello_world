import 'package:flutter/material.dart';
import 'package:hello_world/Controller/KompetensiController.dart';
import 'package:hello_world/Model/KompetensiModel.dart';

class KompetensiProdiPage extends StatefulWidget {
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

  // void _showBidangModal(String prodiId) async {
  //   try {
  //     final bidangList = await _controller.fetchBidangList(prodiId);

  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Bidang Details'),
  //         content: SizedBox(
  //           height: 200,
  //           child: ListView.builder(
  //             itemCount: bidangList.length,
  //             itemBuilder: (context, index) {
  //               return ListTile(
  //                 title: Text(bidangList[index].bidangNama),
  //               );
  //             },
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: Text('Close'),
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to fetch Bidang details')),
  //     );
  //   }
  // }

  void _showBidangModal(String prodiId) async {
  try {
    // Fetch data from controller
    final bidangList = await _controller.fetchBidangList(prodiId);

    // Show modal dialog
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Modal Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail Data Kompetensi Prodi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Modal Body
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Informasi Alert
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        border: Border.all(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
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
                      columnWidths: {
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Prodi:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              bidangList.first.bidangNama, // Assuming all items share the same Prodi name
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Bidang:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: bidangList
                                  .map((bidang) => Text('- ${bidang.bidangNama}'))
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
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Tutup'),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal mengambil detail bidang')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kompetensi Prodi'),
      ),
      body: FutureBuilder<List<KompetensiProdi>>(
        future: _kompetensiList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
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
                  trailing: Icon(Icons.info, color: Colors.blue),
                  onTap: () => _showBidangModal(kompetensi.prodiId.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
