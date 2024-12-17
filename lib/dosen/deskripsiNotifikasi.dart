import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/NotifikasiDosenController.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class DeskripsiNotifikasiPage extends StatelessWidget {
  final String type;
  final int id;
  final String token;
  final NotifikasiDosenController _controller = NotifikasiDosenController();

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
                                ..._buildInfoItems(data, context),
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

  List<Widget> _buildInfoItems(
      Map<String, dynamic> data, BuildContext context) {
    return [
      _buildInfoItem('Judul', _truncateText(data['nama'] ?? '-', 50)),
      _buildInfoItem('Bidang', _truncateText(data['bidang'] ?? '-', 50)),
      _buildInfoItem('Tanggal', data['tanggal_acara'] ?? '-'),
      _buildInfoItem('Mata Kuliah', _truncateText(data['matkul'] ?? '-', 50)),
      _buildInfoItem('Kuota', data['kuota'] ?? '1'),
      _buildInfoItem('Vendor', _truncateText(data['vendor'] ?? '-', 50)),
      _buildInfoItem('Periode', data['periode'] ?? '-'),
      _buildInfoItem(
          'Keterangan', _truncateText(data['keterangan'] ?? '-', 100)),
      _buildInfoItem('Surat Tugas',
          _buildSuratTugasList(data['surat_tugas'] ?? [], context)),
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

  Widget _buildSuratTugasList(dynamic suratTugasData, BuildContext context) {
    if (suratTugasData is List && suratTugasData.isEmpty) {
      return Text(
        '-',
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
      );
    } else if (suratTugasData is Map<String, dynamic>) {
      final namaSurat =
          _truncateText(suratTugasData['nama_surat'] ?? 'Surat Tugas', 30);
      final urlDownload = suratTugasData['file_url'] ?? '#';
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ElevatedButton.icon(
          onPressed: () {
            if (urlDownload != '#') {
              _downloadFile(
                  context, urlDownload, namaSurat); // Pass context here
            }
          },
          icon: const Icon(Icons.download, size: 18),
          label: Text(
            namaSurat,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D47A1),
          ),
        ),
      );
    } else if (suratTugasData is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: suratTugasData.map((surat) {
          final namaSurat =
              _truncateText(surat['nama_surat'] ?? 'Surat Tugas', 30);
          final urlDownload = surat['url'] ?? '#';
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                if (urlDownload != '#') {
                  _downloadFile(
                      context, urlDownload, namaSurat); // Pass context here
                }
              },
              icon: const Icon(Icons.download, size: 18),
              label: Text(
                namaSurat,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return Text(
        'Tidak ada data surat tugas.',
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
      );
    }
  }

  Future<void> _downloadFile(
      BuildContext context, String url, String fileName) async {
    // Meminta izin untuk menyimpan file
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Mendapatkan direktori penyimpanan
        var dir = await getExternalStorageDirectory();
        String savePath = '${dir?.path}/$fileName';

        // Mengunduh file menggunakan Dio
        Dio dio = Dio();
        await dio.download(url, savePath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File berhasil diunduh: $fileName')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengunduh file: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masih dalam pengembangan, silakan download melalui web')),
      );
    }
  }

  String _truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}
