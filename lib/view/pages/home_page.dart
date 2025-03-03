import 'package:flutter/material.dart';
import 'package:flutter_application_agronom_ai/core/constants/app_images.dart';
import 'package:flutter_application_agronom_ai/view/pages/camera_page.dart';
import 'package:flutter_application_agronom_ai/view/pages/history_page.dart';
import 'package:flutter_application_agronom_ai/view/pages/landing_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    LandingPage(),
    CameraPage(),
    HistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 115, 207, 120),
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SvgPicture.asset(AppImages.homeIcon),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SvgPicture.asset(AppImages.cameraIcon),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SvgPicture.asset(AppImages.historyIcon),
                ),
                label: ""),
          ]),
    );
  }
}
