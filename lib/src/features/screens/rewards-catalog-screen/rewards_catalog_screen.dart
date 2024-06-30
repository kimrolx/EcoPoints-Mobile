import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/recycling_log_model.dart';
import '../../../shared/services/recycling_log_service.dart';

class RewardsCatalogScreen extends StatelessWidget {
  static const String route = "/rewards";
  static const String path = "/rewards";
  static const String name = "RewardsCatalogScreen";
  const RewardsCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoPointsColors.lightGray,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            RecyclingLogService recyclingLogService =
                GetIt.instance<RecyclingLogService>();

            RecyclingLogModel newLog = RecyclingLogModel(
              dateTime: DateTime.now(),
              bottlesRecycled: 10,
              pointsGained: 21.52,
            );

            await recyclingLogService.addRecyclingLog(newLog);
            print("Recycling log added and user points updated.");
          },
          child: const Text('Add Recycling Log'),
        ),
      ),
    );
  }
}
