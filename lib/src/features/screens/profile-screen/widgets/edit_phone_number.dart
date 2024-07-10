import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/dialogs/loading_dialog.dart';
import '../../../../shared/services/user_profile_service.dart';

class EditPhoneNumberProfileScreen extends StatefulWidget {
  final TextEditingController numberController;
  final FocusNode numberFn;
  const EditPhoneNumberProfileScreen(
      {super.key, required this.numberController, required this.numberFn});

  @override
  State<EditPhoneNumberProfileScreen> createState() =>
      _EditPhoneNumberProfileScreenState();
}

class _EditPhoneNumberProfileScreenState
    extends State<EditPhoneNumberProfileScreen> {
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();

  final formKey = GlobalKey<FormState>();
  String? phoneNumber;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(widget.numberFn);
    });
  }

  void _validatePhoneNumber() {
    setState(() {
      isValid = formKey.currentState?.validate() ?? false;
    });
  }

  String? _phoneValidator(PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) {
      return "This field is required.";
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone.number)) {
      return "Please enter a valid phone number.";
    } else if (RegExp(r'^[0]+$').hasMatch(phone.number)) {
      return "Phone number cannot be all zeros.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      appBar: AppBar(
        backgroundColor: EcoPointsColors.white,
        centerTitle: true,
        title: Text(
          "Phone Number",
          style: EcoPointsTextStyles.blackTextStyle(
              size: width * 0.045, weight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              onChanged: _validatePhoneNumber,
              child: IntlPhoneField(
                initialCountryCode: 'PH',
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone.completeNumber;
                  });
                },
                focusNode: widget.numberFn,
                decoration: const InputDecoration(
                  hintText: "910 123 4567",
                  hintStyle: TextStyle(color: EcoPointsColors.darkGray),
                  errorStyle: TextStyle(color: EcoPointsColors.red),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                validator: _phoneValidator,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Expanded(
                child: CustomElevatedButton(
                  borderRadius: 8,
                  backgroundColor: isValid
                      ? EcoPointsColors.lightGreen
                      : EcoPointsColors.darkGray,
                  onPressed: isValid ? () => onSave() : () {},
                  child: Text(
                    "Save",
                    style: EcoPointsTextStyles.whiteTextStyle(
                      size: width * 0.04,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      await WaitingDialog.show(
        context,
        future: _userProfileService
            .updateUserPhoneNumber(phoneNumber!)
            .then((_) => Navigator.pop(context)),
        prompt: "Saving...",
      );
    }
  }
}
