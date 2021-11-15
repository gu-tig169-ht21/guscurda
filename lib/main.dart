import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var body;
    return Scaffold(
      appBar: AppBar(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 32),
            Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Add musician'),
                )),
            ListView(
              children: [
                _checkbox('John Bonham'),
                _checkbox('Alex Turner'),
                _checkbox('Elton John'),
                _checkbox('Jimmy Page'),
              ],
              shrinkWrap: true,
            ),
            Container(height: 100),
            _button(),
          ],
        ),
      ),
    );
  }
}

Widget _appbar() {
  return Container(
    height: 53,
    decoration: BoxDecoration(color: Colors.blueGrey),
    child: Center(
      child: Text(
        'Favorite musician',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget _checkbox(String s) {
  return CheckboxListTile(
      title: Text(s),
      value: false,
      onChanged: (value) {
        print('Good Choise');
      });
}

Widget _button() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      OutlinedButton(
        onPressed: () {},
        child: Text("Save"),
      ),
      Container(width: 20),
    ],
  );
}

class SecondView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
