import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String userName;

  const Header({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: width * 0.55), // Space to match the layout
          Text(
            userName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            Icons.account_circle,
            size: 24,
          ),
        ],
      ),
    );
  }
}
