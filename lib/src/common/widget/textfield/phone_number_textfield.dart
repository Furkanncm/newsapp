import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

@immutable
final class PhoneNumberTextfield extends StatefulWidget {
  const PhoneNumberTextfield({required this.phoneController, super.key});

  final TextEditingController phoneController;

  @override
  State<PhoneNumberTextfield> createState() => _PhoneNumberTextfieldState();
}

class _PhoneNumberTextfieldState extends State<PhoneNumberTextfield> {
  late final IUserRepository _userRepository;
  late final IFirebaseDataSource _firebaseDataSource;
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository.instance;
    _firebaseDataSource = FirebaseDataSource.instance;
    isVerified = _userRepository.currentUser?.isPhoneNumberVerified ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar(isRequired: true, text: LocaleKeys.phoneNumber.tr()),
        verticalBox4,
        LuciPhoneTextFormField(
          controller: widget.phoneController,
          labelText: '',
          suffixIcon: isVerified
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                )
              : TextButton(
                  onPressed: () async =>
                      _firebaseDataSource.sendVerificationCodePhoneNumber(
                        phoneNumber: widget.phoneController.text,
                      ),
                  child: LuciText.bodyMedium(
                    'Verify',
                    textColor: AppTheme.successColor,
                  ),
                ),
        ),
      ],
    );
  }
}
