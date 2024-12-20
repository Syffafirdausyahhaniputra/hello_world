import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/NotifikasiDosenController.dart';
import 'deskripsiNotifikasi.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotifikasiDosenController _controller = NotifikasiDosenController();
  Future<List<dynamic>>? _notifikasiFuture;
  String? _token;

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
        _token = token;
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
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade400,
                            Colors.orange.shade300,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_active,
                        size: 24,
                        color: Colors.white,
                      ),
                    ).animate()
                      .scale(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      )
                      .fadeIn(),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notifikasi',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate()
                          .fadeIn(delay: const Duration(milliseconds: 200))
                          .slideX(begin: 0.2, end: 0),
                        const Text(
                          'Pemberitahuan Terbaru',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ).animate()
                          .fadeIn(delay: const Duration(milliseconds: 300))
                          .slideX(begin: 0.2, end: 0),
                      ],
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue.shade50,
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                  // Animated decoration elements
                  ...List.generate(5, (index) {
                    return Positioned(
                      right: -30 + (index * 20).toDouble(),
                      top: -20 + (index * 15).toDouble(),
                      child: Container(
                        width: 150 - (index * 20),
                        height: 150 - (index * 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(0.03 + (index * 0.01)),
                        ),
                      ).animate(
                        onPlay: (controller) => controller.repeat(),
                      ).scale(
                        duration: Duration(seconds: 3 + index),
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                      ).animate(
                        delay: Duration(milliseconds: index * 200),
                      ).fadeIn(duration: const Duration(milliseconds: 600)),
                    );
                  }),
                  // Decorative icons
                  Positioned(
                    right: 40,
                    top: 60,
                    child: Icon(
                      Icons.notifications_none,
                      size: 100,
                      color: Colors.orange.withOpacity(0.1),
                    ).animate(
                      onPlay: (controller) => controller.repeat(),
                    ).scale(
                      duration: const Duration(seconds: 4),
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: FutureBuilder<List<dynamic>>(
                future: _notifikasiFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_off_outlined,
                            color: Colors.grey,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Tidak ada notifikasi',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: snapshot.data!.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return _buildNotificationCard(
                          context,
                          title: item['nama'] ?? 'Tidak ada nama',
                          category: item['type'] ?? 'Tidak ada kategori',
                          status: item['status'] ?? 'Tidak ada status',
                          statusColor: _getStatusColor(item['status']),
                          id: item['id'],
                          type: item['type'],
                          index: index,
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchNotifikasi,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Proses':
        return Colors.blue;
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
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        if (_token != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeskripsiNotifikasiPage(
                type: type,
                id: id,
                token: _token!,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Token tidak ditemukan'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_active,
                  size: 24,
                  color: Colors.orange,
                ),
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
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.label_outline,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: statusColor.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            status == 'Selesai'
                                ? Icons.check_circle_outline
                                : Icons.pending_outlined,
                            size: 16,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ],
          ),
        ).animate(
          delay: Duration(milliseconds: index * 100),
        ).fadeIn(
          duration: const Duration(milliseconds: 500),
        ).slideX(
          begin: 0.2,
          end: 0,
          curve: Curves.easeOutQuad,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
