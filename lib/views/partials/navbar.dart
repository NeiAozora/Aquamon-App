import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Colors.blue;
    Color unselectedColor = Colors.grey;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.plumbing,
            color: currentIndex == 0 ? selectedColor : unselectedColor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: currentIndex == 1 ? selectedColor : unselectedColor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: currentIndex == 2 ? selectedColor : unselectedColor,
          ),
          label: '',
        ),
      ],
      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/aerator');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/history');
            break;
        }
      },
    );
  }
}
