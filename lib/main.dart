import 'dart:developer';
import 'package:flutter/material.dart';
import 'Api.dart';
import 'artistNotifier.dart';
import 'popUp.dart';
import 'package:provider/provider.dart';
import 'ArtistManager.dart';
import 'addArtist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorite Artist',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ChangeNotifierProvider<ArtistNotifier>(
        create: (context) => ArtistNotifier(),
        child: const MyHomePage(title: 'Favorite Artist'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ListManager myListManager = ListManager();

  List<ListManager> list = <ListManager>[];
  String activeFilter = 'All';

  @override
  void initState() {
    var provider = context.read<ArtistNotifier>();
    provider.getArtistName();
    provider.filterText.addListener(() {
      setState(() {
        activeFilter = provider.filterText.value;
      });
    });

    super.initState();
  }

  void _addName(ArtistName item) async {
    context.read<ArtistNotifier>().addArtistName(item);
  }

  void _checkStatus(ArtistName artistName) async {
    await context.read<ArtistNotifier>().setDoneArtistName(artistName);
  }

  void _removeName(ArtistName item) {
    context.read<ArtistNotifier>().removeArtistName(item);
  }

  Icon _getCheckboxIcon(bool state) {
    return state
        ? Icon(
            Icons.check_box_outlined,
            size: 20.0,
            color: Colors.blueGrey,
          )
        : Icon(
            Icons.check_box_outline_blank,
            size: 20.0,
            color: Colors.blueGrey,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      const PopupMenuItem(child: Text('All'), value: 'All'),
                      const PopupMenuItem(
                          child: Text('Marked'), value: 'Marked'),
                      const PopupMenuItem(
                          child: Text('Unmarked'), value: 'Unmarked')
                    ],
                onSelected: (String value) {
                  setState(() {
                    context.read<ArtistNotifier>().filterArtistList(value);
                  });
                }),
          ],
        ),
        body: _buildbody(),
        floatingActionButton: PopupForm(callback: _addName));
  }

  Widget _buildbody() {
    return Consumer<ArtistNotifier>(
      builder: (context, value, child) => value.fatching
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: value.list.length,
              itemBuilder: (context, index) {
                var item = value.list[index];
                return Card(
                  key: UniqueKey(),
                  child: ListTile(
                    title: Text(
                      item.title,
                      style: item.status
                          ? const TextStyle(decoration: TextDecoration.none)
                          : const TextStyle(decoration: TextDecoration.none),
                    ),
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      IconButton(
                        icon: _getCheckboxIcon(item.status),
                        onPressed: () {
                          _checkStatus(item);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 20.0,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {
                          _removeName(item);
                        },
                      ),
                    ]),
                  ),
                );
              }),
    );
  }

  void changeState(ArtistName check) {
    setState(() {
      check.status = !check.status;
    });
  }
}
