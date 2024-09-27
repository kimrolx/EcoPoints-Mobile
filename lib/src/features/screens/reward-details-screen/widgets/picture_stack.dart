import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/misc/out_of_stock_banner.dart';
import '../../../../models/reward_model.dart';
import '../../../../shared/services/firebase_services.dart';
import '../../../../shared/services/user_profile_service.dart';

class PictureStackRewardDetailsScreen extends StatefulWidget {
  final RewardModel reward;
  const PictureStackRewardDetailsScreen({super.key, required this.reward});

  @override
  State<PictureStackRewardDetailsScreen> createState() =>
      _PictureStackRewardDetailsScreenState();
}

class _PictureStackRewardDetailsScreenState
    extends State<PictureStackRewardDetailsScreen> {
  final FirebaseServices firebaseService = GetIt.instance<FirebaseServices>();
  final UserProfileService userService = GetIt.instance<UserProfileService>();

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    bool favoriteStatus = await firebaseService.isFavorite(
        userService.userId!, widget.reward.rewardID);

    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    if (isFavorite) {
      await firebaseService.removeFromFavorites(
          "${userService.userId}", widget.reward.rewardID);
    } else {
      await firebaseService
          .addToFavorites("${userService.userId}", widget.reward.rewardID, {
        'name': widget.reward.rewardName,
        'description': widget.reward.rewardDescription,
        'points': widget.reward.requiredPoint,
        'image': widget.reward.rewardPicture,
        'campus': widget.reward.campus,
        'expiryDate': widget.reward.expiryDate,
      });
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool isSoldOut = widget.reward.rewardStock < 1;

    return Stack(
      children: [
        Container(
          height: height * 0.55,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.reward.rewardPicture),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (isSoldOut) OutOfStockBanner(fontSize: width * 0.06),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.02),
          child: SafeArea(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: EcoPointsColors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.clear),
                    onPressed: () => context.pop(),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: EcoPointsColors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: isFavorite
                        ? const Icon(
                            color: EcoPointsColors.red,
                            CupertinoIcons.heart_fill,
                          )
                        : const Icon(
                            CupertinoIcons.heart,
                          ),
                    onPressed: _toggleFavoriteStatus,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
