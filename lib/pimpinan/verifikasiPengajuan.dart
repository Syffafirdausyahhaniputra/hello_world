import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/NotifikasiPimpinanController.dart';

class VerifikasiPengajuanPage extends StatelessWidget {
  final String type;
  final int id;
  final String token;
  final NotifikasiPimpinanController _controller = NotifikasiPimpinanController();

  VerifikasiPengajuanPage({
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
          'Verifikasi Pengajuan',
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
      body: FutureBuilder<Map<String, dynamic>>(
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
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Judul Dinamis
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pengajuan $type',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: const Color(0xFF0D47A1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Informasi Pengajuan
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
                            _buildInfoItem('Judul', data['Nama $type'] ?? '-'),
                            _buildInfoItem('Bidang', data['Bidang'] ?? '-'),
                            _buildInfoItem('Tanggal', data['Tanggal'] ?? '-'),
                            _buildInfoItem('Mata Kuliah', data['Mata Kuliah'] ?? '-'),
                            _buildInfoItem('Kuota', data['Kuota'] ?? '-'),
                            _buildInfoItem('Biaya', data['Biaya'] ?? '-'),
                            _buildInfoItem('Lokasi', data['Lokasi'] ?? '-'),
                            _buildInfoItem('Vendor', data['Vendor'] ?? '-'),
                            _buildInfoItem('Periode', data['Periode'] ?? '-'),
                            _buildInfoItem('Dosen', _buildDosenList(data['Dosen'] ?? [])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tombol Verifikasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      label: 'Tolak',
                      icon: Icons.close,
                      color: Colors.red,
                      onPressed: () => _verify(context, 'Ditolak'),
                    ),
                    _buildActionButton(
                      label: 'Setuju',
                      icon: Icons.check,
                      color: Colors.green,
                      onPressed: () => _verify(context, 'Diterima'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
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
      children: dosen.map((dosenName) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              const Icon(Icons.person, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                dosenName,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _verify(BuildContext context, String status) async {
    try {
      final result = await _controller.verify(
        type: type,
        id: id,
        status: status,
        token: token,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memproses: $e')),
      );
    }
  }
}
