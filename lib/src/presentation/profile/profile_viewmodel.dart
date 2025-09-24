import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';
import 'package:newsapp/src/common/utils/enums/language_enum.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/localization/localization_repository.dart';
import 'package:newsapp/src/domain/theme/theme_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'profile_viewmodel.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  _ProfileViewModelBase() {
    _themeRepository = ThemeRepository.instance;
    _authRepository = AuthRepository();
    _userRepository = UserRepository();
    setCurrentUser();
  }

  late final ThemeRepository _themeRepository;
  late final IAuthRepository _authRepository;
  late final IUserRepository _userRepository;

  @observable
  UserModel? currentUser;

  @observable
  LanguageEnum? currentLanguage;

  @action
  void toggleTheme(BuildContext context) => _themeRepository.setTheme(context);

  @action
  void setCurrentUser() => currentUser = _userRepository.currentUser;

  Future<void> logOut() async => _authRepository.logOut();

  void getLocale(BuildContext context) {
    final locale = context.locale;
    if (locale.languageCode == StringConstants.tr.toLowerCase()) {
      currentLanguage = LanguageEnum.turkish;
    } else {
      currentLanguage = LanguageEnum.english;
    }
  }

  @action
  void changeLanguage({
    required BuildContext context,
    required LanguageEnum language,
  }) {
    currentLanguage = language;
    LocalizationManager.instance.changeLanguage(
      context: context,
      language: language,
    );
    getLocale(context);
  }
}
