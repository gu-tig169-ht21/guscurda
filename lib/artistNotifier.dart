import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'Api.dart';
import 'ArtistManager.dart';

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

  void addArtistName(ArtistName index) async {
    await Api.addArtistName(index);
    await getArtistName();
  }

  Future<void> setDoneArtistName(ArtistName index) async {
    index.status = !index.status;
    await Api.updateArtistList(index);
    await getArtistName();
  }

  void removeArtistName(ArtistName index) async {
    await Api.removeItem(index.id);
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
