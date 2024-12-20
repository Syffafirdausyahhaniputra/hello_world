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

  // Previous methods remain the same
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF0D47A1),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Dosen Bidang',
          style: TextStyle(
            color: Color(0xFF0D47A1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with Search
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Box
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F9FF),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF0D47A1),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF0D47A1),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _filterDosen,
                            decoration: const InputDecoration(
                              hintText: "Cari Dosen...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // List Dosen
            Expanded(
              child: isloading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daftar Dosen',
                            style: TextStyle(
                              fontSize: screenWidth > 600 ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D47A1),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Expanded(
                            child: filteredDosen != null && filteredDosen!.isNotEmpty
                                ? ListView.builder(
                                    itemCount: filteredDosen!.length,
                                    itemBuilder: (context, index) {
                                      return _buildDosenCard(
                                        context,
                                        bidangId: filteredDosen![index]['bidang_id'].toString(),
                                        dosenId: filteredDosen![index]['dosen_id'].toString(),
                                        name: filteredDosen![index]['dosen2']['user']['nama'],
                                        nip: filteredDosen![index]['dosen2']['user']['nip'],
                                        screenWidth: screenWidth,
                                        index: index,
                                      );
                                    },
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          size: screenWidth * 0.15,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        const Text(
                                          'Tidak ada dosen ditemukan',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDosenCard(
    BuildContext context, {
    required String bidangId,
    required String dosenId,
    required String name,
    required String nip,
    required double screenWidth,
    required int index,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SertifikasiPage(
                  dosenName: name,
                  dosenNip: nip,
                  dosenId: dosenId,
                  bidangId: bidangId,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar with gradient background
                Container(
                  width: screenWidth * 0.14,
                  height: screenWidth * 0.14,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: screenWidth * 0.08,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                
                // Dosen information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        nip,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrow icon
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF0D47A1),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}