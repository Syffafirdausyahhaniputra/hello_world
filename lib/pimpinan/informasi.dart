import 'package:flutter/material.dart';
import 'package:hello_world/Controller/BidangController.dart';
import 'package:hello_world/Controller/DetailBidang.dart';

class SertifikasiPage extends StatefulWidget {
  final String dosenName;
  final String dosenNip;
  final String dosenId;
  final String bidangId;

  SertifikasiPage(
      {Key? key,
      required this.dosenNip,
      required this.dosenName,
      required this.bidangId,
      required this.dosenId})
      : super(key: key);

  @override
  _SertifikasiPageState createState() => _SertifikasiPageState();
}

class _SertifikasiPageState extends State<SertifikasiPage> {
  final Detailbidang control = Detailbidang();
  List<dynamic>? sertifikasiList;
  List<dynamic>? pelatihanList;
  int jumlahSertifikasi = 0;
  bool isloading = true;

  // Daftar sertifikasi palsu
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Mengambil data sertifikasi dari API
    final apiRes =
        await control.getDetailDosen(widget.bidangId, widget.dosenId);

    setState(() {
      jumlahSertifikasi = apiRes['jumlahSertifikasiPelatihan'];
      sertifikasiList = apiRes['sertifikasi'];
      pelatihanList = apiRes['pelatihan'];
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Atas: Informasi dosen
              _buildHeader(),
              const SizedBox(height: 20),
              // Garis Pembatas
              const Divider(
                color: Color(0xFF0D47A1), // Warna biru tua
                thickness: 2,
              ),
              const SizedBox(height: 20),
              // Bagian Bawah: Sertifikasi
              const Text(
                'Sertifikasi Dan Pelatihan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Menggunakan ListView.builder untuk daftar sertifikasi
              isloading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // Agar tidak berbenturan dengan scroll parent
                          itemCount: sertifikasiList!.length,
                          itemBuilder: (context, index) {
                            final sertifikasi =
                                sertifikasiList![index]['sertif'];
                            return _buildSertifikasiItem(
                              sertifikasi['nama_sertif']!,
                              sertifikasi['bidang']['bidang_nama']!,
                              sertifikasi['tanggal']!,
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // Agar tidak berbenturan dengan scroll parent
                          itemCount: pelatihanList!.length,
                          itemBuilder: (context, index) {
                            final pelatihan =
                                pelatihanList![index]['pelatihan'];
                            return _buildSertifikasiItem(
                              pelatihan['nama_pelatihan']!,
                              pelatihan['bidang']['bidang_nama']!,
                              pelatihan['tanggal']!,
                            );
                          },
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  // Membuat bagian atas yang menampilkan informasi dosen dan jumlah sertifikasi
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF0D47A1), // Warna biru tua
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dosenName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Warna teks hitam
                  ),
                ),
                Text(
                  widget.dosenNip,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const Text(
                  'Dosen Jurusan Teknologi Informasi',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Jumlah sertifikasi
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF0D47A1), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                jumlahSertifikasi.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1), // Warna biru
                ),
              ),
              const Text(
                'Sertifikasi dan Pelatihan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Membuat item sertifikasi
  Widget _buildSertifikasiItem(String title, String category, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0D47A1), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            category,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            date,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
