import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier {
  int _counter = 0;

  void increment() {
    _counter++;
    notifyListeners();
  }

  int get counter => _counter;

  void filter(String value) {}
}

class SecondView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondViewState();
  }
}

class SecondViewState extends State<StatefulWidget> {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyState(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text("Live Shows"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('How many times have you seen them perform?'),
              Consumer<MyState>(
                  builder: (context, state, child) =>
                      Text('${state.counter}', style: TextStyle(fontSize: 36))),
              CounterIndex(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Provider.of<MyState>(context, listen: false).increment();
          },
        ),
      ),
    );
  }
}

class CounterIndex extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<MyState>(builder: (context, state, child) {
      if (state.counter == 0) {
        return Text('Click to count');
      } else if (state.counter > 0 && state.counter < 10) {
        return Text('Nice!');
      }
      return Text('A real fan!!');
    });
  }
}


//  IconButton(
//             icon: Icon(Icons.arrow_right),
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => SecondView()));
//             },
//           )