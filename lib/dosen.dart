import 'package:flutter/material.dart';
import 'bottombar.dart'; // Import file bottombar.dart
import 'dosen/dashboard.dart'; // Import file riwayat.dart (AssignmentPage)
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
    Dashboard(), // Halaman Dashboard
    HistoryPage(), // Halaman Assignment dari riwayat.dart
    NotificationPage(), // Halaman Notifikasi dari notifikasi.dart
    ProfilePage(), // Halaman Profil dari profil.dart
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