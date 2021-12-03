import 'addArtist.dart';

class ListManager {
  List<ArtistName> artistName = [];

  void addArtistName(ArtistName item) {
    artistName.add(item);
  }

  void removeArtistName({required String id}) {
    artistName.removeWhere((element) => element.id == id);
  }

  void markAsComplete({required String id}) {
    artistName.firstWhere((element) => element.id == id).status = true;
  }

  void markAsIncomplete({required String id}) {
    artistName.firstWhere((element) => element.id == id).status = false;
  }

  void markStatus({required int index}) {
    artistName[index].status = !artistName[index].status;
  }
}
