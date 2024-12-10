import 'package:flutter/material.dart';

class VerifikasiPengajuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Latar belakang abu-abu lembut
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Tombol Back
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Judul
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pengajuan',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Informasi Pengajuan
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoItem(Icons.person, 'Nama', 'Zulfa Ulinnuha'),
                            _buildInfoItem(Icons.badge, 'NIP', '2241760119'),
                            _buildInfoItem(Icons.description, 'Jenis', 'Sertifikasi'),
                            const Divider(thickness: 1, height: 30),
                            _buildInfoItem(Icons.domain, 'Bidang', 'Cloud Computing'),
                            const Text(
                              'Mata Kuliah:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildMataKuliahList([
                              'Jaringan Komputer',
                              'Konsep Teknologi Informasi',
                            ]),
                            const Divider(thickness: 1, height: 30),
                            _buildInfoItem(
                                Icons.event, 'Tanggal Acara', '20 Januari 2021'),
                            _buildInfoItem(Icons.date_range, 'Berlaku Hingga',
                                '19 September 2025'),
                            _buildInfoItem(Icons.business, 'Vendor', 'Kemendikbud'),
                            _buildInfoItem(Icons.category, 'Jenis', 'Profesi'),
                            _buildInfoItem(Icons.timeline, 'Periode', '2024 – ganjil'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol Aksi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        label: 'Tolak',
                        icon: Icons.close,
                        color: Colors.red,
                        onPressed: () {
                          // Logic untuk menolak
                        },
                      ),
                      _buildActionButton(
                        label: 'Setuju',
                        icon: Icons.check,
                        color: Colors.green,
                        onPressed: () {
                          // Logic untuk menyetujui
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFF0D47A1), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMataKuliahList(List<String> mataKuliah) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: mataKuliah.map((mk) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                mk,
                style: const TextStyle(fontSize: 16, color: Colors.black),
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
        style: const TextStyle(fontSize: 16, color: Colors.white),
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
}
