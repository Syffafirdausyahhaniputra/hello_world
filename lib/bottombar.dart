import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 5), // Padding around the navbar
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF002366), // Background color of the nav bar
          borderRadius: BorderRadius.circular(20), // Rounded edges
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, isSelected: selectedIndex == 0, index: 0), // Home
            _buildNavItem(Icons.assignment, isSelected: selectedIndex == 1, index: 1), // Assignment
            _buildNavItem(Icons.notifications, isSelected: selectedIndex == 2, index: 2), // Notifications
            _buildNavItem(Icons.person, isSelected: selectedIndex == 3, index: 3), // Person
          ],
        ),
      ),
    );
  }

  // Create a reusable nav item widget with animation
  Widget _buildNavItem(IconData icon, {required bool isSelected, required int index}) {
    return GestureDetector(
      onTap: () {
        onItemTapped(index); // Trigger the provided callback on tap
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.amber[200] : Colors.amber, // Highlighted when selected
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.6),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Shadow for selected icon
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          size: isSelected ? 28 : 24, // Larger icon size when selected
          color: isSelected ? const Color(0xFF002366) : Colors.black, // Color transition
        ),
      ),
    );
  }
}
