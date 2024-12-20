import 'package:flutter/material.dart';
import 'package:hello_world/core/sharedPref.dart';
import 'package:hello_world/dosen/inputDataPelatihan.dart';
import 'package:hello_world/dosen/inputDataSertifikasi.dart';
import 'package:hello_world/dosen/pelatihan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/DashboardController.dart';
import '../Model/DataSertifikasiModel.dart';
import '../Model/DataPelatihanModel.dart';
import 'dataSertif.dart';
import 'dropdown.dart';
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
      final token = await Sharedpref.getToken();
      if (token == '') throw Exception('Token is missing');
      
      final data = await DashboardController.getDashboardData(token);
      
      setState(() {
        userName = data['user']['nama'];
        jumlahSertifikasiPelatihan = data['jumlahSertifikasiPelatihan'];
        sertifikasiList = data['sertifikasi'];
        pelatihanList = data['pelatihan'];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading dashboard data: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF5F7FA), Color(0xFFE4E7EB)],
              ),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      _buildWelcomeSection(),
                      SizedBox(height: 25),
                      _buildStatsCard(),
                      SizedBox(height: 25),
                      _buildSectionsArea(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

Widget _buildWelcomeSection() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 24),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Selamat Datang',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 16),
        Text(
          userName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildStatsCard() {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DataSertifPage()),
    ),
    child: Container(
      padding: EdgeInsets.all(16), // Margin lebih kecil agar lebih fleksibel
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0D47A1).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      width: double.infinity, // Lebar penuh
      height: MediaQuery.of(context).size.height * 0.17, // Tinggi responsif
      child: Row(
        children: [
          Icon(
            Icons.trending_up,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.1, // Ikon responsif
          ),
          SizedBox(width: 16), // Jarak antara ikon dan teks
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sertifikasi & Pelatihan',
                  maxLines: 3, // Maksimal dua baris untuk teks panjang
                  overflow: TextOverflow.ellipsis, // Potong teks jika terlalu panjang
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: MediaQuery.of(context).size.width * 0.06, // Font responsif
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8), // Jarak vertikal
                Text(
                  jumlahSertifikasiPelatihan.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.08, // Font responsif
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}




  Widget _buildSectionsArea() {
    return Column(
      children: [
        _buildSection(
          'Sertifikasi',
          sertifikasiList,
          true,
          Color(0xFF0D47A1),
          Icons.verified_user,
        ),
        SizedBox(height: 25),
        _buildSection(
          'Pelatihan',
          pelatihanList,
          false,
          Color(0xFF0D47A1),
          Icons.school,
        ),
      ],
    );
  }

  Widget _buildSection(
    String title,
    List<dynamic> dataList,
    bool isSertifikasi,
    Color accentColor,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataList.length,
                padding: EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  final data = dataList[index];
                  return _buildListItem(
                    data,
                    isSertifikasi,
                    accentColor,
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: accentColor,
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => isSertifikasi
                        ? DataSertifikasiForm()
                        : DataPelatihanForm(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
    dynamic data,
    bool isSertifikasi,
    Color accentColor,
  ) {
    final title = isSertifikasi
        ? (data as DataSertifikasiModel).namaSertifikasi
        : (data as DataPelatihanModel).namaPelatihan;
    final subtitle = isSertifikasi
        ? data.bidangSertifikasi
        : data.bidangPelatihan;
    final date = isSertifikasi
        ? data.masaBerlaku
        : data.tanggal;

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => isSertifikasi
                  ? SertifPage(id: data.id)
                  : PelatihanPage(id: data.id),
            ),
          );
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              date,
              style: TextStyle(
                color: accentColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: accentColor,
        ),
      ),
    );
  }
}