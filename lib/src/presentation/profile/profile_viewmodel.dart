import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';
import 'package:newsapp/src/domain/theme/theme_repository.dart';

part 'profile_viewmodel.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  final ThemeRepository _repository = ThemeRepository.instance;
  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource.instance;

  @action
  void toggleTheme(BuildContext context) {
    _repository.setTheme(context); // otomatik güncellenir
  }

  Future<void> logOut() async {
    await _firebaseDataSource.logOut();
  }
}
