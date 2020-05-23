import 'package:flutter/material.dart';

void main() {
  runApp(ValueNotifierCounterApp());
}

class ValueNotifierCounterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Patterns',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ValueNotifier Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  //int _counter = 0;

  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
    _counter.value += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            //Builds when get an valueNotifier is changed/updated
            ValueListenableBuilder(
              builder: (BuildContext context, int value, Widget child) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
              valueListenable: _counter,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
