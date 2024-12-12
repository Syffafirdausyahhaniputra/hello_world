import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'verifikasiPengajuan.dart'; // Import halaman verifikasiPengajuan.dart
import '../Controller/NotifikasiPimpinanController.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotifikasiPimpinanController _controller =
      NotifikasiPimpinanController();
  Future<List<dynamic>>? _notifikasiFuture;
  String? _token; // Tambahkan properti token

  @override
  void initState() {
    super.initState();
    _fetchNotifikasi();
  }

  Future<void> _fetchNotifikasi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token; // Simpan token
        _notifikasiFuture = _controller.list(token: token);
      });
    } else {
      setState(() {
        _notifikasiFuture = Future.error('Token tidak ditemukan');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.01),
                  const Text(
                    'Notifikasi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  FutureBuilder<List<dynamic>>(
                    future: _notifikasiFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'Tidak ada notifikasi',
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      } else {
                        return Column(
                          children: snapshot.data!.map((item) {
                            return _buildNotificationCard(
                              context,
                              title: item['nama'] ?? 'Tidak ada nama',
                              category: item['type'] ?? 'Tidak ada kategori',
                              status: item['status'] ?? 'Tidak ada status',
                              statusColor: _getStatusColor(item['status']),
                              id: item['id'],
                              type: item['type'],
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Proses':
        return Colors.blueGrey;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required String title,
    required String category,
    required String status,
    required Color statusColor,
    required int id,
    required String type,
  }) {
    return GestureDetector(
      onTap: () {
        if (_token != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifikasiPengajuanPage(
                type: type,
                id: id,
                token: _token!, // Pastikan token dikirim
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Token tidak ditemukan')),
          );
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.notifications,
                size: 40,
                color: Colors.orange,
              ),
              const SizedBox(width: 16),
              Expanded(
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
                    const SizedBox(height: 8),
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
