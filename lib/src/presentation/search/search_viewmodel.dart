import 'dart:async';

import 'package:mobx/mobx.dart';

part 'search_viewmodel.g.dart';

class SearchViewmodel = _SearchViewmodelBase with _$SearchViewmodel;

abstract class _SearchViewmodelBase with Store {
  @observable
  int lastestIndex = 0;

  Timer? debounce;

  @action
  void changeIndex(int index) => lastestIndex = index;

  @action
  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      // Arama kodları buraya
    });
  }


}
