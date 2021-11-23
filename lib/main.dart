import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'SecondView.dart';
import 'NewaddMusicianView.dart';

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
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondView()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 32),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
            ),
            buildbody(),
            Container(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: (Icon(Icons.add)), onPressed: () => addMusicianView()),
    );
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

  Widget buildbody() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildItem(list[index]);
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
}
