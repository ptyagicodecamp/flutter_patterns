import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//
//void main() {
//  final Store<int> store = Store<int>(reducer, initialState: 0);
//  runApp(ReduxCounterApp(store));
//}

enum CounterAction { increment }

//Reducer can be defined in a separate class: reducer.dart
//Converts from one state to another state
int reducer(int prevState, dynamic action) {
  if (action == CounterAction.increment) {
    prevState = prevState + 1;
  }

  return prevState;
}

class ReduxCounterApp extends StatelessWidget {
  final Store<int> store;
  ReduxCounterApp(this.store);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Patterns',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Redux Demo'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  int _counter = 0;

  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<int, String>(
              converter: (store) => store.state.toString(),
              builder: (context, viewModel) {
                return Text(
                  viewModel,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<int, VoidCallback>(
        converter: (store) {
          return () => store.dispatch(CounterAction.increment);
        },
        builder: (context, callback) {
          return FloatingActionButton(
            onPressed: callback,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
