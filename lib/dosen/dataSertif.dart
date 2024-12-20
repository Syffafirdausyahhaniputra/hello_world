import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/Controller/ListAllDataController.dart';
import '../header.dart';
import 'sertif.dart';
import 'package:hello_world/Model/DataSertifikasiModel.dart';
import 'package:hello_world/Model/DataPelatihanModel.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this package for custom fonts

class DataSertifPage extends StatefulWidget {
  @override
  _DataSertifPageState createState() => _DataSertifPageState();
}

class _DataSertifPageState extends State<DataSertifPage> {
  List<DataSertifikasiModel> sertifikasiList = [];
  List<DataPelatihanModel> pelatihanList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final result = await ListAllDataController.getListAllData();
      setState(() {
        sertifikasiList = result['sertifikasi'];
        pelatihanList = result['pelatihan'];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light grey background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Sertifikasi',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue[900],
                        ),
                      ),
                      Text(
                        'dan Pelatihan',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[900]!),
                      ),
                    )
                  : _buildSertifList(context, width, height),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSertifList(BuildContext context, double width, double height) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.blue[900],
            labelColor: Colors.blue[900],
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Sertifikasi'),
              Tab(text: 'Pelatihan'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildCertificationList(sertifikasiList, context, width, height),
                _buildTrainingList(pelatihanList, context, width, height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationList(List<DataSertifikasiModel> list, BuildContext context, double width, double height) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return _buildSertifItem(
          context: context,
          id: item.id,
          title: item.namaSertifikasi ?? '',
          subtitle: item.bidangSertifikasi ?? '',
          date: item.masaBerlaku ?? '',
          width: width * 0.9,
        );
      },
    );
  }

  Widget _buildTrainingList(List<DataPelatihanModel> list, BuildContext context, double width, double height) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return _buildSertifItem(
          context: context,
          id: item.id,
          title: item.namaPelatihan ?? '',
          subtitle: item.bidangPelatihan ?? '',
          date: item.tanggal ?? '',
          width: width * 0.9,
        );
      },
    );
  }

  Widget _buildSertifItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String date,
    required double width,
    required int id,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SertifPage(id: id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
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
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.verified_outlined,
                  color: Colors.blue[900],
                  size: 30,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[900],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.blue[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}