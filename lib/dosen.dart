import 'package:flutter/material.dart';
import 'bottombar.dart'; // Pastikan sudah benar
import 'dosen/dashboard.dart'; // Import file dashboard.dart (Dashboard)
import 'dosen/riwayat.dart'; // Import file riwayat.dart (HistoryPage)
import 'dosen/notifikasi.dart'; // Import file notifikasi.dart (NotificationPage)
import 'dosen/profil.dart'; // Import file profil.dart (ProfilePage)

class DosenPage extends StatefulWidget {
  final String token; // Tambahkan parameter token

  const DosenPage({super.key, required this.token});

  @override
  _DosenPageState createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Inisialisasi halaman dengan token
    _pages = [
      Dashboard(token: widget.token), // Pass token ke Dashboard
      HistoryPage(),
      NotificationPage(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update halaman aktif
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: SafeArea(
          child: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped, // Pass the callback function
        ),
      ),
    );
  }
}
