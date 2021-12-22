import 'package:flutter/material.dart';
import 'ArtistManager.dart';

class NewArtistView extends StatefulWidget {
  final Function callback;
  const NewArtistView({Key? key, required this.callback}) : super(key: key);

  @override
  _NewArtistViewState createState() => _NewArtistViewState();
}

class _NewArtistViewState extends State<NewArtistView> {
  var titleController = TextEditingController();

  void _addName() {
    var item = ArtistName(title: titleController.text, status: false);

    setState(() {
      titleController.clear();
    });
    widget.callback(item);
    Navigator.pop(context);
  }

  Widget _addArtistView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Musician'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Artist',
                ),
              ),
              TextButton(
                onPressed: () {
                  _addName();
                },
                child: const Text('Add'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(context: context, builder: (_) => _addArtistView());
      },
      tooltip: 'Add',
      child: const Icon(Icons.add),
    );
  }
}
