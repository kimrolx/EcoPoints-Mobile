import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecopoints/src/components/constants/colors/ecopoints_colors.dart';
import 'package:ecopoints/src/features/screens/account-screen/account_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../routes/router.dart';
import '../rewards-catalog-screen/rewards_catalog_screen.dart';
import '../scan_qr_screen.dart';
import 'home_screen.dart';

class HomeWrapper extends StatefulWidget {
  final Widget? child;
  const HomeWrapper({super.key, this.child});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int index = 0;

  List<String> routes = [
    HomeScreen.route,
    RewardsCatalogScreen.route,
    ScanQRScreen.route,
    AccountScreen.route
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child ?? const Placeholder(),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55.0,
        buttonBackgroundColor: EcoPointsColors.darkGreen,
        backgroundColor: EcoPointsColors.lighGray,
        animationDuration: const Duration(milliseconds: 250),
        onTap: (i) {
          setState(() {
            index = i;
            GlobalRouter.I.router.go(routes[i]);
          });
        },
        items: [
          _buildNavItem(
            selectedIndex: index,
            itemIndex: 0,
            icon: CupertinoIcons.house_fill,
            unselectedIcon: CupertinoIcons.home,
            label: "Home",
          ),
          _buildNavItem(
            selectedIndex: index,
            itemIndex: 1,
            icon: CupertinoIcons.gift_fill,
            unselectedIcon: CupertinoIcons.gift,
            label: "Rewards",
          ),
          Icon(
            CupertinoIcons.qrcode,
            semanticLabel: "QR Code",
            color:
                index == 2 ? EcoPointsColors.lighGray : EcoPointsColors.black,
          ),
          _buildNavItem(
            selectedIndex: index,
            itemIndex: 3,
            icon: CupertinoIcons.person_fill,
            unselectedIcon: CupertinoIcons.person,
            label: "Account",
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int selectedIndex,
    required int itemIndex,
    required IconData icon,
    IconData? unselectedIcon,
    required String label,
  }) {
    return Icon(
      selectedIndex == itemIndex ? icon : unselectedIcon ?? icon,
      semanticLabel: label,
      color: selectedIndex == itemIndex
          ? EcoPointsColors.lighGray
          : EcoPointsColors.black,
    );
  }
}
