import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/NotifikasiPimpinanController.dart';

class DeskripsiNotifikasiPage extends StatelessWidget {
  final String type;
  final int id;
  final String token;
  final NotifikasiPimpinanController _controller =
      NotifikasiPimpinanController();

  DeskripsiNotifikasiPage({
    required this.type,
    required this.id,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
        title: Text(
          'Detail Notifikasi',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<Map<String, dynamic>>(
            future: _controller.show(type: type, id: id, token: token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Terjadi kesalahan: ${snapshot.error}',
                    style: GoogleFonts.poppins(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text(
                    'Data tidak ditemukan.',
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              final data = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$type',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: const Color(0xFF0D47A1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ..._buildInfoItems(data),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildInfoItems(Map<String, dynamic> data) {
    return [
      _buildInfoItem('Judul', _truncateText(data['nama'] ?? '-', 50)),
      _buildInfoItem('Bidang', _truncateText(data['bidang'] ?? '-', 50)),
      _buildInfoItem('Tanggal', data['tanggal_acara'] ?? '-'),
      _buildInfoItem('Mata Kuliah', _truncateText(data['matkul'] ?? '-', 50)),
      _buildInfoItem('Kuota', data['kuota'] ?? '1'),
      _buildInfoItem('Biaya', data['biaya'] ?? '-'),
      _buildInfoItem('Lokasi', _truncateText(data['lokasi'] ?? '-', 50)),
      _buildInfoItem('Vendor', _truncateText(data['vendor'] ?? '-', 50)),
      _buildInfoItem('Periode', data['periode'] ?? '-'),
      _buildInfoItem(
          'Keterangan', _truncateText(data['keterangan'] ?? '-', 100)),
      _buildInfoItem('Dosen', _buildDosenList(data['dosen_list'] ?? [])),
    ];
  }

  Widget _buildInfoItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          value is Widget
              ? value
              : Text(
                  value.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
          const Divider(thickness: 1, height: 20),
        ],
      ),
    );
  }

  Widget _buildDosenList(List<dynamic> dosen) {
    if (dosen.isEmpty) {
      return Text(
        '-',
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dosen.map((dosenData) {
        final namaDosen = _truncateText(dosenData['nama_dosen'] ?? '-', 30);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              const Icon(Icons.person, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                namaDosen,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}
