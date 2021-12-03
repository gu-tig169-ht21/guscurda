import 'dart:developer';
import 'package:http/http.dart' as http;
import 'addArtist.dart';
import 'dart:convert';

String url = 'https://todoapp-api-pyq5q.ondigitalocean.app';
String apiKey = '8d89bbbd-62e5-44c3-97ea-b81ab773da13';

class Api {
  static Future<List<ArtistName>> getItems() async {
    var response = await http.get(Uri.parse('$url/todos?key=$apiKey'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data.isEmpty
          ? <ArtistName>[]
          : data.map<ArtistName>((obj) => ArtistName.fromJson(obj)).toList();
    }

    return [];
  }

  static Future<void> addArtistName(ArtistName artistName) async {
    artistName.status = false;
    await http.post(Uri.parse('$url/todos?key=$apiKey'),
        body: jsonEncode(artistName.toJson()),
        headers: {'Content-Type': 'application/json'});
  }

  static Future updateShoppingItem(ArtistName todo) async {
    var response = await http.put(
        Uri.parse('$url/todos/${todo.id}?key=$apiKey'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(todo.toJson()));
    if (response.statusCode == 200) {
      return response;
    } else {
      log('error on update ${response.body}');
      return null;
    }
  }

  static Future removeTodoModel(String todoId) async {
    try {
      var response =
          await http.delete(Uri.parse('$url/todos/$todoId?key=$apiKey'));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (exception) {
      log('exception on remove');
    }
  }
}
