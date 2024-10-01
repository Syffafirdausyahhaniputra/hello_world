import 'package:flutter/material.dart';
import 'bottombar.dart'; // Pastikan sudah benar
import 'dosen/dashboard.dart'; // Import file dashboard.dart (Dashboard)
import 'dosen/riwayat.dart'; // Import file riwayat.dart (AssignmentPage)
import 'dosen/notifikasi.dart'; // Import file notifikasi.dart (NotificationPage)
import 'dosen/profil.dart'; // Import file profil.dart (ProfilePage)

class DosenPage extends StatefulWidget {
  const DosenPage({super.key});

  @override
  _DosenPageState createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Dashboard(), // Nama kelas Dashboard sudah sesuai dengan kelas di dashboard.dart
    HistoryPage(), // Pastikan nama ini benar di riwayat.dart
    NotificationPage(), // Pastikan nama ini benar di notifikasi.dart
    ProfilePage(), // Pastikan nama ini benar di profil.dart
  ];

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
