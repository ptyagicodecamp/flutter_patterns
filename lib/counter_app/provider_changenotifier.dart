import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//{link: https://pub.dev/packages/provider#-example-tab-}

//Provider package is a wrapper around the InheritedWidget to make them easier to use and more reusable.
//CounterApp uses Provider package + ChangeNotifier
void main() {
  //Providers are above ProviderCounterApp.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Counter(),
        ),
      ],
      child: ProviderCounterApp(),
    ),
  );
}

//ChangeNotifier. Notifies about the change/update in counter
class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void incrementCounter() {
    _count++;
    //Notifies about the change in counter
    notifyListeners();
  }
}

class ProviderCounterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Patterns',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Provider + ChangeNotifier Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

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

            //Extracting into separate widget helps it to rebuild independently of [HomePage]
            const Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Using read() instead of watch() helps NOT TO rebuild the widget when there's change in count (or Counter ChangeNotifier notifies)
        onPressed: () => context.read<Counter>().incrementCounter(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      //Rebuilds [MyHomePage] when [Counter] ChangeNotifier notifies about the change in count
      '${context.watch<Counter>().count}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
