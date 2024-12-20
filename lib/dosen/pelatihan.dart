import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/Controller/DetailPelatihan.dart';
import '../header.dart';

class PelatihanPage extends StatefulWidget {
  final int id;

  PelatihanPage({required this.id});

  @override
  _PelatihanPageState createState() => _PelatihanPageState();
}

class _PelatihanPageState extends State<PelatihanPage> {
  final Detailpelatihan _detailpelatihan = Detailpelatihan();
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      var res = await _detailpelatihan.getDetailPelatihan(widget.id);
      setState(() {
        data = res;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load training details'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[900]!),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(Icons.arrow_back, color: Colors.blue[900]),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Detail Pelatihan',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue[900],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Training Details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['nama_pelatihan'] ?? 'Pelatihan',
                            style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildTrainingDetailsCard(width),
                          SizedBox(height: 16),
                          _buildAdditionalInfoCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTrainingDetailsCard(double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Bidang Pelatihan', data['bidang'] ?? '-'),
            _buildDetailRow('Level Pelatihan', data['level'] ?? '-'),
            _buildDetailRow('Mata Kuliah', data['matkul'] ?? 'Teknologi Informasi'),
            _buildDetailRow('Vendor', data['vendor'] ?? '-'),
            _buildDetailRow('Tanggal Mulai', data['tanggal'] ?? '-'),
            _buildDetailRow('Tanggal Akhir', data['tanggal_akhir'] ?? '-'),
            _buildDetailRow('Kuota', data['kuota']?.toString() ?? '-'),
            _buildDetailRow('Lokasi', data['lokasi'] ?? '-'),
            _buildDetailRow('Biaya', data['biaya'] ?? '-'),
            _buildDetailRow('Periode', data['periode'] ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.blue[900],
              size: 30,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Pastikan untuk memperhatikan detail pelatihan dan persyaratan yang berlaku.',
                style: GoogleFonts.poppins(
                  color: Colors.blue[900],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            ': ',
            style: GoogleFonts.poppins(
              color: Colors.grey[800],
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.blue[900],
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}