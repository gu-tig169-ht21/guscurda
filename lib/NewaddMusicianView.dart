import 'package:flutter/material.dart';

class NewaddMusicianView extends StatefulWidget {
  const NewaddMusicianView({Key? key}) : super(key: key);

  @override
  _NewaddMusicianViewState createState() => _NewaddMusicianViewState();
}

class _NewaddMusicianViewState extends State<NewaddMusicianView> {
  TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Add Musician"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: textFieldController,
            onEditingComplete: () => save(),
          ),
          TextButton(onPressed: () => save(), child: Text('Add'))
        ],
      ),
    );
  }

  //kolla om det finns något värde i Textfeild, och i så fall spara
  void save() {
    if (textFieldController.text.isNotEmpty) {
      Navigator.of(context).pop(textFieldController.text);
    }
  }
}
