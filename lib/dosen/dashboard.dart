import 'package:flutter/material.dart';
import 'package:hello_world/core/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan import
import '../Controller/DashboardController.dart';
import '../Model/DataSertifikasiModel.dart';
import '../Model/DataPelatihanModel.dart';
import '../header.dart';
import 'inputData.dart';
import 'dataSertif.dart';
import 'sertif.dart';

class Dashboard extends StatefulWidget {
  final String token;

  Dashboard({required this.token});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = 'Loading...';
  int jumlahSertifikasiPelatihan = 0;
  List<DataSertifikasiModel> sertifikasiList = [];
  List<DataPelatihanModel> pelatihanList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      // Ambil token dari SharedPreferences jika diperlukan
      final token = await Sharedpref.getToken();

      if (token == '') {
        throw Exception('Token is missing');
      }

      final data = await DashboardController.getDashboardData(token);

      setState(() {
        userName = data['user']['nama'];
        jumlahSertifikasiPelatihan = data['jumlahSertifikasiPelatihan'];
        print(jumlahSertifikasiPelatihan);
        sertifikasiList = data['sertifikasi'];
        pelatihanList = data['pelatihan'];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading dashboard data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(userName: userName),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  _buildInfoCard(
                    title: 'Sertifikasi dan Pelatihan',
                    value: jumlahSertifikasiPelatihan.toString(),
                    width: width * 1,
                    borderColor: const Color(0xFF0D47A1),
                    context: context,
                  ),
                  SizedBox(height: height * 0.05),
                  _buildSection('Sertifikasi', context, width, height,
                      dataList: sertifikasiList, isSertifikasi: true),
                  SizedBox(height: height * 0.02),
                  _buildSection('Pelatihan', context, width, height,
                      dataList: pelatihanList, isSertifikasi: false),
                ],
              ),
            ),
          );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required double width,
    required Color borderColor,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DataSertifPage()),
        );
      },
      child: Container(
        width: width,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 5, color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    BuildContext context,
    double width,
    double height, {
    required List<dynamic> dataList,
    required bool isSertifikasi,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Atur agar scroll horizontal
      child: Center(
        child: Stack(
          children: [
            Container(
              width: width * 0.9,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(
                  top: 24.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 48.0), // Ruang untuk ikon
              decoration: BoxDecoration(
                color: const Color(0xFF0D47A1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: dataList.map((data) {
                  return _buildRecommendationItem(
                    title: isSertifikasi
                        ? (data as DataSertifikasiModel).namaSertifikasi
                        : (data as DataPelatihanModel).namaPelatihan,
                    subtitle: isSertifikasi
                        ? (data as DataSertifikasiModel).bidangSertifikasi
                        : (data as DataPelatihanModel).bidangPelatihan,
                    date: isSertifikasi
                        ? (data as DataSertifikasiModel).masaBerlaku
                        : (data as DataPelatihanModel).masaBerlaku,
                    id: isSertifikasi
                        ? (data as DataSertifikasiModel).id
                        : (data as DataPelatihanModel).id,
                    width: width * 0.8,
                    context: context,
                  );
                }).toList(),
              ),
            ),
            Positioned(
              top: 0,
              left: width * 0.1,
              right: width * 0.1,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFB509),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10, // Pastikan ikon ada di dalam section
              right: width * 0.05,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InputDataPage()));
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFB509),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem({
    String title = '',
    String subtitle = '',
    String date = '',
    required int id,
    double? width,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SertifPage(id: id)));
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
