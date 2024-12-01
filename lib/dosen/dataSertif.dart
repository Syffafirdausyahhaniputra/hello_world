import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/Controller/ListAllDataController.dart';
import '../header.dart'; // Import the Header component
import 'sertif.dart'; // Pastikan nama file dan path benar

class DataSertifPage extends StatefulWidget {
  @override
  _DataSertifPageState createState() => _DataSertifPageState();
}

class _DataSertifPageState extends State<DataSertifPage> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final result = await ListAllDataController.getListAllData();
      setState(() {
        var res = result['data']; // Cast the data to a list of maps

        // Example data, you can replace with dynamic data or a list
        data = List.generate(
          res.length,
          (index) => {
            'title': res[index]['nama'] ?? '',
            'subtitle': res[index]['bidang'] ?? '',
            'date': res[index]['masa_berlaku'] ?? '',
          },
        );
        print('Data loaded successfully');
        print(res);
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (isLoading) {
      _loadData();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              Stack(
                children: [
                  Header(
                      userName: 'Zulfa Ulinnuha'), // Reuse the Header component
                  Positioned(
                    left: 0,
                    top: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40, // Adjust the size as per your design
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20, // Adjust icon size to fit inside the circle
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Data',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sertifikasi dan Pelatihan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _buildSertifList(
                      context, width, height), // Pass context here
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSertifList(BuildContext context, double width, double height) {
    // Example data, you can replace with dynamic data or a list

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: data.map((item) {
          return Column(
            children: [
              _buildSertifItem(
                context: context, // Pass context here
                title: item['title'] ?? '',
                subtitle: item['subtitle'] ?? '',
                date: item['date'] ?? '',
                width: width * 0.9,
              ),
              SizedBox(height: height * 0.02),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSertifItem({
    required BuildContext context, // Add context as a parameter
    required String title,
    required String subtitle,
    required String date,
    required double width,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, // Use the passed context here
          MaterialPageRoute(
            builder: (context) => SertifPage(), // Halaman sertif.dart
          ),
        );
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 2),
            Text(
              date,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
