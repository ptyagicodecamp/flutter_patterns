import 'package:flutter/material.dart';

import 'recipes.dart';
import 'router.dart' as router;

final List<RecipeWidget> recipes = [
  RecipeWidget(
      "Default CounterApp - Vanilla Pattern",
      "Using setState() for updating the counter number",
      router.VANILLA_COUNTER_APP,
      "lib/counter_app/vanilla.dart",
      ""),
  RecipeWidget(
      "Default CounterApp - ValueNotifier",
      "Using ValueNotifier for updating the counter number",
      router.VALUE_NOTIFIER_COUNTER_APP,
      "lib/counter_app/value_notifier.dart",
      ""),
  RecipeWidget(
      "Default CounterApp - Provider + ChangeNotifier",
      "Using Provider package with ChangeNotifier for updating the counter number",
      router.VALUE_NOTIFIER_COUNTER_APP,
      "lib/counter_app/provider_changenotifier.dart",
      ""),
];

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Patterns'),
      ),
      body: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            return recipes[index];
          }),
    );
  }
}
