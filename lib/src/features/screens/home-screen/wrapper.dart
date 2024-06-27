import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecopoints/src/components/constants/colors/ecopoints_colors.dart';
import 'package:ecopoints/src/features/screens/account-screen/account_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../routes/router.dart';
import '../rewards_catalog_screen.dart';
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
        height: 60.0,
        buttonBackgroundColor: EcoPointsColors.darkGreen,
        backgroundColor: EcoPointsColors.lighGray,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (i) {
          setState(() {
            index = i;
            GlobalRouter.I.router.go(routes[i]);
          });
        },
        items: const [
          Icon(
            CupertinoIcons.home,
            semanticLabel: "Home",
          ),
          Icon(
            CupertinoIcons.gift,
            semanticLabel: "Rewards",
          ),
          Icon(
            CupertinoIcons.qrcode,
            semanticLabel: "QR",
          ),
          Icon(
            CupertinoIcons.person,
            semanticLabel: "Account",
          ),
        ],
      ),
    );
  }
}
