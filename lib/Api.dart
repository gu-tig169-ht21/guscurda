import 'package:flutter/material.dart';

import 'main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

String url = 'https://todoapp-api-pyq5q.ondigitalocean.app';
String apiKey = '70d5b860-4cc9-4412-8943-74e5479e7f37';

class Api {
  static Future<List<ArtistName>> getArtist() async {
    var response = await http.get(
      Uri.parse('$url/todos?key=$apiKey'),
    );
    String bodyString = response.body;
    var json = jsonDecode(bodyString);
    return json.map((data) => ArtistName.fromJson(data)).toList();
  }

  static Future<List<ArtistName>> addArtist(ArtistName item) async {
    Map<String, dynamic> json = ArtistName.toJson(item);
    var bodyString = jsonEncode(json);
    var response = await http.post(
      Uri.parse('$url/todos?key=$apiKey'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);
    return list.map<ArtistName>((data) {
      return ArtistName.fromJson(data);
    }).toList();
  }

  static Future deleteItem(String item) async {
    var response = await http.delete(
      Uri.parse('$url/todos?key=$apiKey'),
    );
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ArtistName>((data) {
      return ArtistName.fromJson(data);
    }).toList();
  }
}
