import 'package:flutter/material.dart';
import 'package:hello_world/Controller/DetailBidang.dart';
import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/Model/DosenModel.dart';
import 'informasi.dart';

class DosenBidangPage extends StatefulWidget {
  final String id;

  const DosenBidangPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DosenBidangPage> createState() => _DosenBidangPageState();
}

class _DosenBidangPageState extends State<DosenBidangPage> {
  Detailbidang control = Detailbidang();
  List<dynamic>? listDosen;
  bool isloading = true;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic>? filteredDosen;

  @override
  void initState() {
    super.initState();
    setDetailBidang();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> setDetailBidang() async {
    Map<String, dynamic> apiRes = await control.getDetailBidangs(widget.id);

    setState(() {
      isloading = false;
      listDosen = apiRes['dosen'];
      filteredDosen = listDosen;
    });
  }

  void _filterDosen(String query) {
    setState(() {
      filteredDosen = listDosen?.where((dosen) {
        final name = dosen['dosen2']['user']['nama'].toLowerCase();
        final nip = dosen['dosen2']['user']['nip'].toLowerCase();
        return name.contains(query.toLowerCase()) || 
               nip.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dosen Bidang',
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 36 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSearchBox(screenWidth),
                    SizedBox(height: screenHeight * 0.02),
                    isloading
                        ? const Center(child: CircularProgressIndicator())
                        : _buildDosenList(context, screenWidth),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Responsive Search Box
  Widget _buildSearchBox(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF0D47A1),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _filterDosen,
              decoration: InputDecoration(
                hintText: "CARI",
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.grey),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // Responsive Dosen List
  Widget _buildDosenList(BuildContext context, double screenWidth) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: filteredDosen != null && filteredDosen!.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredDosen!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: screenWidth * 0.03,
                  ),
                  child: _buildDosenItem(
                    context,
                    bidangId: filteredDosen![index]['bidang_id'].toString(),
                    dosenId: filteredDosen![index]['dosen_id'].toString(),
                    name: filteredDosen![index]['dosen2']['user']['nama'],
                    description: filteredDosen![index]['dosen2']['user']['nip'],
                    screenWidth: screenWidth,
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Tidak ada dosen ditemukan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
    );
  }

  // Responsive Dosen Item
  Widget _buildDosenItem(
    BuildContext context, {
    required String bidangId,
    required String dosenId,
    required String name,
    required String description,
    required double screenWidth,
    bool isMain = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SertifikasiPage(
              dosenName: name,
              dosenNip: description,
              dosenId: dosenId,
              bidangId: bidangId,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFEFB509),
              radius: screenWidth * 0.07,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: screenWidth * 0.06,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 16 : 14,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}