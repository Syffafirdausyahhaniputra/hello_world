import 'package:flutter/material.dart';
import 'package:hello_world/Controller/DetailPelatihan.dart';
import '../header.dart'; // Import the Header component

class PelatihanPage extends StatefulWidget {
  final int id;

  PelatihanPage({required this.id});

  @override
  _PelatihanPageState createState() => _PelatihanPageState();
}

class _PelatihanPageState extends State<PelatihanPage> {
  final Detailpelatihan _detailpelatihan = Detailpelatihan();

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    // Load data here
    var res = await _detailpelatihan.getDetailPelatihan(widget.id);
    print(res);
    setState(() {
      data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              Stack(
                children: [
                  Header(userName: 'Zulfa Ulinnuha'),
                  Positioned(
                    left: 0,
                    top: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: _detailpelatihan.getDetailPelatihan(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        Text(
                          data['nama_pelatihan'] ?? 'pelatihan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        _buildCertificateDetails(width),
                        SizedBox(height: height * 0.02),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificateDetails(double width) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0D47A1), width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informasi pelatihan
          Text(
            'Bidang Pelatihan\t\t: ${data['bidang']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Level Pelatihan\t\t: ${data['level']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Mata Kuliah\t\t: ${data['matkul'] ?? 'Teknologi Informasi'}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Vendor\t: 20 ${data['vendor']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Tanggal Mulai\t: ${data['tanggal']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Tanggal Akhir\t: ${data['tanggal_akhir']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Kuota\t: ${data['kuota']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Lokasi\t: ${data['lokasi']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Biaya\t: ${data['biaya']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Periode\t: ${data['periode']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16), // Spacer
        ],
      ),
    );
  }
}
