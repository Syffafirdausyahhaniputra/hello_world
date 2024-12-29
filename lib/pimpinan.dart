import 'package:flutter/material.dart';
import 'bottombar.dart'; // Pastikan sudah benar
import 'pimpinan/dashboard.dart'; // Import file dashboard.dart (Dashboard)
import 'pimpinan/kompetensi.dart'; // Import file riwayat.dart (AssignmentPage)
import 'pimpinan/notifikasi.dart'; // Import file notifikasi.dart (NotificationPage)
import 'pimpinan/profil.dart'; // Import file profil.dart (ProfilePage)

class PimpinanPage extends StatefulWidget {
  const PimpinanPage({super.key});

  @override
  _PimpinanPageState createState() => _PimpinanPageState();
}

class _PimpinanPageState extends State<PimpinanPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(), // Nama kelas Dashboard sudah sesuai dengan kelas di dashboard.dart
    KompetensiProdiPage(), // Pastikan nama ini benar di riwayat.dart
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
      debugShowCheckedModeBanner: false,
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
