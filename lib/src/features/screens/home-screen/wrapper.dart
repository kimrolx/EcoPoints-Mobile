import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/user_profile_model.dart';
import '../../../providers/bottom_sheet_provider.dart';
import '../../../routes/router.dart';
import '../../../shared/services/user_service.dart';
import '../account-screen/account_screen.dart';
import '../rewards-catalog-screen/rewards_catalog_screen.dart';
import '../scan-qr-screen/scan_qr_screen.dart';
import 'home_screen.dart';
import 'widgets/set_target_bottom_sheet.dart';

class HomeWrapper extends StatefulWidget {
  final Widget? child;
  const HomeWrapper({super.key, this.child});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int index = 0;
  double points = 0.0;
  double? targetPoints;
  DateTime? targetDate;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserFirestoreService _userService =
      GetIt.instance<UserFirestoreService>();

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  List<String> routes = [
    HomeScreen.route,
    RewardsCatalogScreen.route,
    ScanQRScreen.route,
    AccountScreen.route
  ];

  Future<void> loadUserProfile() async {
    UserProfileModel? userProfile = await _userService.getUserProfile();
    if (userProfile != null) {
      setState(() {
        points = userProfile.points;
        targetPoints = userProfile.targetPoints;
        targetDate = userProfile.targetDate;
      });
    }
  }

  void _updateTargets() {
    loadUserProfile();
  }

  void _displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: EcoPointsColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (context) => TargetBottomSheetHomeScreen(
          onUpdate: _updateTargets, initialDate: targetDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetProvider(
      showBottomSheet: _displayBottomSheet,
      child: Scaffold(
        key: _scaffoldKey,
        body: IndexedStack(
          index: index,
          children: const [
            HomeScreen(),
            RewardsCatalogScreen(),
            ScanQRScreen(),
            AccountScreen(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 55.0,
          buttonBackgroundColor: EcoPointsColors.darkGreen,
          backgroundColor: EcoPointsColors.lightGray,
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
              color: index == 2
                  ? EcoPointsColors.lightGray
                  : EcoPointsColors.black,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 50,
          height: 50,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: EcoPointsColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              elevation: 1.5,
              child: const Icon(
                CupertinoIcons.qrcode_viewfinder,
                size: 40,
                color: EcoPointsColors.black,
              ),
            ),
          ),
        ),
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
          ? EcoPointsColors.lightGray
          : EcoPointsColors.black,
    );
  }
}
