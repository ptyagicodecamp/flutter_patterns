import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  final _bloc = CounterBloc();

//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }

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
            StreamBuilder(
              stream: _bloc.counter,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.eventSink.add(CounterEvent.increment),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    //Close bloc's stream controllers
    _bloc.dispose();
  }
}

enum CounterEvent { increment }

class CounterBloc {
  int _counter = 0;
  //Controller for State
  final _stateController = StreamController<int>();

  //State stream's Sink to add states into
  StreamSink<int> get _stateSink => _stateController.sink;

  //Stream of states. public
  Stream<int> get counter => _stateController.stream;

  //Interface putting events into sink _eventController's sink.
  final _eventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get eventSink => _eventController.sink;

  //Listening to incoming UI events and mapping them into corresponding output States
  CounterBloc() {
//    _eventController.stream.listen(
//      (event) {
//        _mapEventToState(event);
//      },
//    );

    //shorthand
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    //Increment counter if event is matched
    if (event == CounterEvent.increment) _counter++;

    //update the _counter value into stateController's sink (_stateSink)
    _stateSink.add(_counter);
  }

  //close stream controllers to stop memory leak
  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
