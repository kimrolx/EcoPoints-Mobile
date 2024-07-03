import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/properties/ecopoints_properties.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../shared/services/user_service.dart';
import '../../../../shared/utils/date_formatter_util.dart';

class TargetBottomSheetHomeScreen extends StatefulWidget {
  final VoidCallback onUpdate;
  final DateTime? initialDate;
  const TargetBottomSheetHomeScreen(
      {super.key, required this.onUpdate, this.initialDate});

  @override
  State<TargetBottomSheetHomeScreen> createState() =>
      _TargetBottomSheetHomeScreenState();
}

class _TargetBottomSheetHomeScreenState
    extends State<TargetBottomSheetHomeScreen> {
  final UserFirestoreService _userService =
      GetIt.instance<UserFirestoreService>();

  late GlobalKey<FormState> formKey;
  late TextEditingController targetController;
  late FocusNode targetFn;
  DateTime? _selectedDate;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    targetController = TextEditingController();
    targetFn = FocusNode();
    _selectedDate = widget.initialDate;
  }

  @override
  void dispose() {
    targetController.dispose();
    targetFn.dispose();
    super.dispose();
  }

  void _validate() {
    setState(() {
      _isValid = (formKey.currentState?.validate() ?? false) &&
          (targetController.text.isNotEmpty &&
              double.tryParse(targetController.text) != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        decoration: const BoxDecoration(
            color: EcoPointsColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        padding: EdgeInsets.only(
          left: width * 0.04,
          right: width * 0.04,
          top: height * 0.015,
          bottom: MediaQuery.of(context).viewInsets.bottom + height * 0.02,
        ),
        child: SizedBox(
          height: height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: height * 0.007,
                width: width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: EcoPointsColors.lightGray,
                ),
              ),
              Gap(height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Set Target",
                    style: EcoPointsTextStyles.darkGreenTextStyle(
                      size: width * 0.04,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Gap(width * 0.02),
                  Image.asset("assets/icons/target-icon.png"),
                ],
              ),
              Gap(height * 0.03),
              Text(
                EcopointsProperties.helpKeepTrack,
                textAlign: TextAlign.center,
                style: EcoPointsTextStyles.grayTextStyle(
                  size: width * 0.035,
                  weight: FontWeight.normal,
                ),
              ),
              Gap(height * 0.015),
              pointsTextField(
                width,
                targetController,
                targetFn,
                formKey,
                (value) => setState(() => _validate()),
              ),
              Gap(height * 0.03),
              Container(
                height: height * 0.06,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: EcoPointsColors.lightGreenShade,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.01,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Target Date",
                        style: EcoPointsTextStyles.darkGreenTextStyle(
                          size: width * 0.035,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                              _validate();
                            });
                          }
                        },
                        child: _selectedDate == null
                            ? Container(
                                width: width * 0.12,
                                height: height * 0.035,
                                decoration: BoxDecoration(
                                  color: EcoPointsColors.darkGreen,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(
                                  CupertinoIcons.add,
                                  color: EcoPointsColors.white,
                                ),
                              )
                            : Text(
                                DateFormatterUtil.formatDateWithoutTime(
                                  _selectedDate!,
                                ),
                                style: EcoPointsTextStyles.blackTextStyle(
                                  size: width * 0.035,
                                  weight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(height * 0.015),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomElevatedButton(
                          backgroundColor: EcoPointsColors.red,
                          borderRadius: 50,
                          width: width * 0.05,
                          onPressed: () {
                            onClearTargetsClick();
                          },
                          child: Text(
                            "Clear",
                            style: EcoPointsTextStyles.whiteTextStyle(
                              size: width * 0.04,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                        CustomElevatedButton(
                          backgroundColor: _isValid
                              ? EcoPointsColors.darkGreen
                              : EcoPointsColors.lightGray,
                          borderRadius: 50,
                          onPressed:
                              _isValid ? () => onSetTargetClick() : () {},
                          child: Text(
                            "Set Target",
                            style: EcoPointsTextStyles.whiteTextStyle(
                              size: width * 0.04,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pointsTextField(
    double width,
    TextEditingController targetController,
    FocusNode targetFn,
    GlobalKey<FormState> formKey,
    Function setModalState,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              controller: targetController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "0.00",
                hintStyle: EcoPointsTextStyles.grayTextStyle(
                  size: width * 0.07,
                  weight: FontWeight.w600,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
              ),
              style: EcoPointsTextStyles.darkGreenTextStyle(
                size: width * 0.07,
                weight: FontWeight.w600,
              ),
              onChanged: (value) {
                setModalState(() {
                  _validate();
                });
              },
              onEditingComplete: () {
                targetFn.unfocus();
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              validator: MultiValidator([
                PatternValidator(
                  r'^\d*\.?\d+$',
                  errorText: 'Enter a valid number',
                ),
              ]).call,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  onSetTargetClick() async {
    if (_isValid) {
      double? targetPoints = double.tryParse(targetController.text);
      DateTime? targetDate = _selectedDate;

      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await _userService.updateUserProfileTarget(user.uid,
              targetPoints: targetPoints, targetDate: targetDate);

          widget.onUpdate();
          Navigator.of(context).pop();
        } else {
          print('No user is currently logged in.');
        }
      } catch (e) {
        print('Error updating user profile: $e');
      }
    }
  }

  onClearTargetsClick() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print("I AM CLICKED");

      if (user != null) {
        print("User is: $user");
        await _userService.resetTargets(user.uid);

        widget.onUpdate();
        Navigator.of(context).pop();
      } else {
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Error clearing targets: $e');
    }
  }
}
