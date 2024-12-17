import 'package:flutter/material.dart';
import 'package:hello_world/Controller/BidangController.dart';
import 'package:hello_world/Controller/DetailBidang.dart';

class SertifikasiPage extends StatefulWidget {
  final String dosenName;
  final String dosenNip;
  final String dosenId;
  final String bidangId;

  const SertifikasiPage({
    Key? key,
    required this.dosenNip,
    required this.dosenName,
    required this.bidangId,
    required this.dosenId,
  }) : super(key: key);

  @override
  _SertifikasiPageState createState() => _SertifikasiPageState();
}

class _SertifikasiPageState extends State<SertifikasiPage> {
  final Detailbidang control = Detailbidang();
  List<dynamic>? sertifikasiList;
  List<dynamic>? pelatihanList;
  int jumlahSertifikasi = 0;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final apiRes = await control.getDetailDosen(widget.bidangId, widget.dosenId);

    setState(() {
      jumlahSertifikasi = apiRes['jumlahSertifikasiPelatihan'];
      sertifikasiList = apiRes['sertifikasi'];
      pelatihanList = apiRes['pelatihan'];
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Responsive Header
                    _buildHeader(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    // Divider
                    Divider(
                      color: const Color(0xFF0D47A1),
                      thickness: 2,
                      indent: screenWidth * 0.02,
                      endIndent: screenWidth * 0.02,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Sertifikasi Title
                    Text(
                      'Sertifikasi Dan Pelatihan',
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 28 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Sertifikasi and Pelatihan List
                    isloading
                        ? const Center(child: CircularProgressIndicator())
                        : _buildCertificationList(screenWidth),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Responsive Header
  Widget _buildHeader(double screenWidth, double screenHeight) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = screenWidth > 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Responsive Row for Dosen Info
            isWideScreen
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildDosenAvatar(screenWidth),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(child: _buildDosenDetails(screenWidth)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: _buildDosenAvatar(screenWidth)),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDosenDetails(screenWidth),
                    ],
                  ),
            SizedBox(height: screenHeight * 0.02),
            // Sertifikasi Counter
            _buildSertifikasiCounter(screenWidth),
          ],
        );
      },
    );
  }

// Replace the existing _buildDosenAvatar and _buildDosenDetails methods with these:

// Enhanced Dosen Avatar
Widget _buildDosenAvatar(double screenWidth) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: const Color(0xFF0D47A1),
        width: 4,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: CircleAvatar(
      radius: screenWidth * 0.1,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person,
        size: screenWidth * 0.1,
        color: const Color(0xFF0D47A1),
      ),
    ),
  );
}

// Enhanced Dosen Details
Widget _buildDosenDetails(double screenWidth) {
  return Container(
    padding: EdgeInsets.all(screenWidth * 0.03),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(
        color: const Color(0xFF0D47A1).withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nama Dosen with Decorative Underline
        Stack(
          children: [
            Text(
              widget.dosenName,
              style: TextStyle(
                fontSize: screenWidth > 600 ? 26 : 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0D47A1).withOpacity(0.5),
                      const Color(0xFFEFB509).withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.02),
        
        // NIP with Icon
        Row(
          children: [
            Icon(
              Icons.badge_outlined,
              color: const Color(0xFF0D47A1),
              size: screenWidth * 0.05,
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Text(
                widget.dosenNip,
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 20 : 16,
                  color: Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        
        SizedBox(height: screenWidth * 0.02),
        
        // Department with Chip-like Design
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.school_outlined,
                color: const Color(0xFF0D47A1),
                size: screenWidth * 0.04,
              ),
              SizedBox(width: screenWidth * 0.02),
              Flexible(
                child: Text(
                  'Dosen Jurusan Teknologi Informasi',
                  style: TextStyle(
                    fontSize: screenWidth > 600 ? 18 : 14,
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

 // Enhanced Sertifikasi Counter
Widget _buildSertifikasiCounter(double screenWidth) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFF0D47A1),
          const Color(0xFF1565C0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    padding: EdgeInsets.all(screenWidth * 0.05),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              jumlahSertifikasi.toString(),
              style: TextStyle(
                fontSize: screenWidth > 600 ? 64 : 52,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              '',
              style: TextStyle(
                fontSize: screenWidth > 600 ? 24 : 20,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          'Sertifikasi dan Pelatihan',
          style: TextStyle(
            fontSize: screenWidth > 600 ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Enhanced Certification List
Widget _buildCertificationList(double screenWidth) {
  final combinedList = [
    ...?sertifikasiList?.map((item) => {
          'title': item['sertif']['nama_sertif'],
          'category': item['sertif']['bidang']['bidang_nama'],
          'date': item['sertif']['tanggal'],
          'type': 'Sertifikasi',
        }),
    ...?pelatihanList?.map((item) => {
          'title': item['pelatihan']['nama_pelatihan'],
          'category': item['pelatihan']['bidang']['bidang_nama'],
          'date': item['pelatihan']['tanggal'],
          'type': 'Pelatihan',
        }),
  ];

  return combinedList.isNotEmpty
      ? ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: combinedList.length,
          itemBuilder: (context, index) {
            final item = combinedList[index];
            return _buildSertifikasiItem(
              item['title']!,
              item['category']!,
              item['date']!,
              item['type']!,
              screenWidth,
            );
          },
        )
      : Center(
          child: Column(
            children: [
              Icon(
                Icons.no_accounts_outlined,
                size: screenWidth * 0.2,
                color: Colors.grey[400],
              ),
              Text(
                'Tidak ada sertifikasi atau pelatihan',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
}

// Enhanced Sertifikasi Item
Widget _buildSertifikasiItem(
  String title,
  String category,
  String date,
  String type,
  double screenWidth,
) {
  final Color typeColor = type == 'Sertifikasi' 
      ? const Color.fromARGB(255, 204, 214, 204) 
      : const Color.fromARGB(255, 204, 212, 219);

  return Container(
    margin: EdgeInsets.only(bottom: screenWidth * 0.04),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: typeColor.withOpacity(0.5),
        width: 2,
      ),
      gradient: LinearGradient(
        colors: [
          typeColor.withOpacity(0.05),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: typeColor.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: typeColor,
              width: 5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  type == 'Sertifikasi' 
                      ? Icons.card_membership 
                      : Icons.school,
                  color: typeColor,
                  size: screenWidth * 0.06,
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 16 : 14,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 12,
                      color: typeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.02),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[600],
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: screenWidth > 600 ? 16 : 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}