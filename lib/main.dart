import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'SecondView.dart';
import 'NewaddMusicianView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController textFieldController = TextEditingController();

  List<ArtistName> list = <ArtistName>[];

  String activeFilter = 'All';

  @override
  void initState() {
    list.add(ArtistName(title: 'John Bonham'));
    list.add(ArtistName(title: 'Alex Turner'));
    list.add(ArtistName(title: 'Elton John'));
    list.add(ArtistName(title: 'Jimmy Page'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Favorite Musician"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('All'), value: 'All'),
              const PopupMenuItem(child: Text('Marked'), value: 'Marked'),
              const PopupMenuItem(child: Text('Unmarked'), value: 'Unmarked')
            ],
            onSelected: (String value) {
              setState(() {
                activeFilter = value;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              child: Text('Live Shows'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 160),
                primary: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondView()));
              },
            ),
            Container(height: 32),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
            ),
            buildbody(filter(list)),
            Container(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: (Icon(Icons.add)),
          backgroundColor: Colors.blueGrey,
          onPressed: () => addMusicianView()),
    );
  }

  List<ArtistName> filter(List<ArtistName> listToFilter) {
    if (activeFilter == 'Marked') {
      return listToFilter
          .where((ArtistName item) => item.complete == true)
          .toList();
    }
    if (activeFilter == 'Unmarked') {
      return listToFilter
          .where((ArtistName item) => item.complete == false)
          .toList();
    }

    return listToFilter;
  }

  void setComplete(ArtistName check) {
    setState(() {
      check.complete = !check.complete;
    });
  }

  void removeItem(ArtistName item) {
    list.remove(item);
  }

  void addArtist(ArtistName item) {
    list.add(item);
  }

  void addMusicianView() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewaddMusicianView();
    })).then((title) {
      addArtist(ArtistName(title: title));
    });
  }

  Widget buildbody(List<ArtistName> filteredList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return buildItem(filteredList[index]);
      },
    );
  }

//sätter värdet till Complete onTap & tar bort item från lista i en swipe funktion
  Widget buildItem(ArtistName item) {
    return Dismissible(
      key: Key(item.hashCode.toString()),
      onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red[600],
      ),
      child: ListTile(
        title: Text(item.title),
        trailing: Checkbox(value: item.complete, onChanged: null),
        onTap: () => setComplete(item),
      ),
    );
  }
}

class ArtistName {
  String title;
  bool complete;

  ArtistName({
    required this.title,
    this.complete = false,
  });

  static Map<String, dynamic> toJson(ArtistName item) {
    return {
      'title': item.title,
      'done': item.complete,
    };
  }

  static ArtistName? fromJson(Map<String, dynamic> json) {
    ArtistName(
      title: json['title'],
      complete: json['done'],
    );
  }
}
