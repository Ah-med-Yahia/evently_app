import 'package:evently_app/tabs/home/home_tab.dart';
import 'package:evently_app/tabs/love/love_tab.dart';
import 'package:evently_app/tabs/map/map_tab.dart';
import 'package:evently_app/tabs/profile/profile_tab.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/nav_bar_icon.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currrentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const MapTab(),
    const LoveTab(),
    const ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 2,
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          elevation: 0,
          onTap: (index) {
            if (currrentIndex == index) return;
            currrentIndex = index;
            setState(() {});
          },
          currentIndex: currrentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: NavBarIcon(image: AppAssets.homeUnselectedIcon),
                activeIcon: NavBarIcon(image: AppAssets.homeSelectedIcon),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: NavBarIcon(image: AppAssets.mapUnselectedIcon),
                activeIcon: NavBarIcon(image: AppAssets.mapSelectedIcon),
                label: 'Map'),
            BottomNavigationBarItem(
                icon: NavBarIcon(image: AppAssets.likeUnselectedIcon),
                activeIcon: NavBarIcon(image: AppAssets.likeSelectedIcon),
                label: 'Likes'),
            BottomNavigationBarItem(
                icon: NavBarIcon(image: AppAssets.profileUnselectedIcon),
                activeIcon: NavBarIcon(image: AppAssets.profileSelectedIcon),
                label: 'Profile'),
          ],
        ),
      ),
      body: tabs[currrentIndex],
    );
  }
}
