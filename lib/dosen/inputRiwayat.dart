import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputHasilPage extends StatelessWidget {
  const InputHasilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'INPUT HASIL',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const InputHasilForm(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0D47A1),
    );
  }
}

class InputHasilForm extends StatefulWidget {
  const InputHasilForm({Key? key}) : super(key: key);

  @override
  _InputHasilFormState createState() => _InputHasilFormState();
}

class _InputHasilFormState extends State<InputHasilForm> {
  final TextEditingController _tanggalAcaraController = TextEditingController();

  @override
  void dispose() {
    _tanggalAcaraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal Acara',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _tanggalAcaraController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'Unggah Dokumen',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload, size: 40, color: Colors.grey[400]),
                const SizedBox(height: 8),
                Text(
                  'Unggah dokumen di sini',
                  style: GoogleFonts.montserrat(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),

        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEFB509),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(120, 40),
            ),
            onPressed: () {
              // Implement submission logic here
            },
            child: Text(
              'KIRIM',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}