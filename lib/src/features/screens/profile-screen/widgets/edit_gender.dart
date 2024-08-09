import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/dialogs/loading_dialog.dart';
import '../../../../shared/services/user_profile_service.dart';

class EditGenderProfileScreen extends StatefulWidget {
  final TextEditingController genderController;
  const EditGenderProfileScreen({super.key, required this.genderController});

  @override
  State<EditGenderProfileScreen> createState() =>
      _EditGenderProfileScreenState();
}

class _EditGenderProfileScreenState extends State<EditGenderProfileScreen> {
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.genderController.text;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.clear),
                    onPressed: () {
                      //TODO: change to gorouter
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Gender",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.045, weight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: _selectedGender != null ? () => onSave() : () {},
                    child: Text(
                      "Save",
                      style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.04,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              RadioListTile(
                title: Text(
                  'Male',
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.w500,
                  ),
                ),
                value: 'Male',
                controlAffinity: ListTileControlAffinity.trailing,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text(
                  'Female',
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.w500,
                  ),
                ),
                value: 'Female',
                controlAffinity: ListTileControlAffinity.trailing,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text(
                  'Prefer not to say',
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.w500,
                  ),
                ),
                value: 'Prefer not to say',
                controlAffinity: ListTileControlAffinity.trailing,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSave() async {
    await WaitingDialog.show(context,
        future: _userProfileService
            .updateUserGender(_selectedGender!)
            .then((_) => Navigator.pop(context)),
        prompt: "Saving...");
  }
}
