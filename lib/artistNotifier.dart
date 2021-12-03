import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'Api.dart';
import 'addArtist.dart';

class ArtistNotifier extends ChangeNotifier {
  List<ArtistName> _cachedList = [];
  List<ArtistName> list = [];
  ValueNotifier<String> filterText = ValueNotifier('All');
  bool fatching = false;

  Future getArtistName() async {
    fatching = true;
    list = await Api.getItems();
    _cachedList = list;
    fatching = false;
    notifyListeners();
  }

  void addArtistName(ArtistName todo) async {
    await Api.addArtistName(todo);
    await getArtistName();
  }

  Future<void> setDoneArtistName(ArtistName todo) async {
    todo.status = !todo.status;
    await Api.updateShoppingItem(todo);
    await getArtistName();
  }

  void removeArtistName(ArtistName todo) async {
    await Api.removeTodoModel(todo.id);
    await getArtistName();
  }

  void filterArtistList(String filterValue) {
    filterText.value = filterValue;
    list = _cachedList.where((element) {
      if (filterValue == 'Marked') return element.status;
      if (filterValue == 'Unmarked') return !element.status;
      return true;
    }).toList();
    notifyListeners();
  }
}
