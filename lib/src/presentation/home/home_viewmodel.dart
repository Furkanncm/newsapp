import 'package:mobx/mobx.dart';

part 'home_viewmodel.g.dart';

class HomeViewmodel = _HomeViewmodelBase with _$HomeViewmodel;

abstract class _HomeViewmodelBase with Store {
  @observable
  int lastestIndex = 0;

  @observable
  bool isSeeAll = false;

  @action
  void changeIndex(int index) => lastestIndex = index;

  @action
  void changeIsSeeAll() => isSeeAll = !isSeeAll;
}
