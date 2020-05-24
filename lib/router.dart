import 'package:flutter/material.dart';
import 'package:flutterpatterns/counter_app/flutter_bloc.dart';
import 'package:flutterpatterns/counter_app/vanilla.dart';
import 'package:flutterpatterns/screen_args.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'codefile.dart';
import 'counter_app/provider_changenotifier.dart';
import 'counter_app/redux.dart';
import 'counter_app/value_notifier.dart';
import 'home.dart';
import 'unknown.dart';

const String HOME = "/";
const String SHOW_CODE_FILE = 'SHOW_CODE_FILE';
const String VANILLA_COUNTER_APP = 'VANILLA_COUNTER_APP';
const String VALUE_NOTIFIER_COUNTER_APP = 'VALUE_NOTIFIER_COUNTER_APP';
const String CHANGE_NOTIFIER_COUNTER_APP = 'CHANGE_NOTIFIER_COUNTER_APP';
const String BLOC_COUNTER_APP = 'BLOC_COUNTER_APP';
const String REDUX_COUNTER_APP = 'REDUX_COUNTER_APP';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  print(routeSettings.name);

  switch (routeSettings.name) {
    case HOME:
      return MaterialPageRoute(builder: (context) => Home());
      break;

    case VANILLA_COUNTER_APP:
      return MaterialPageRoute(builder: (context) => VanillaCounterApp());
      break;

    case VALUE_NOTIFIER_COUNTER_APP:
      return MaterialPageRoute(builder: (context) => ValueNotifierCounterApp());
      break;

    case CHANGE_NOTIFIER_COUNTER_APP:
      return MaterialPageRoute(
        //Provider (Counter) stays above the app (ProviderCounterApp)
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => Counter(),
            ),
          ],
          child: ProviderCounterApp(),
        ),
      );
      break;

    case BLOC_COUNTER_APP:
      return MaterialPageRoute(builder: (context) => FlutterBlocCounterApp());
      break;

    case REDUX_COUNTER_APP:
      return MaterialPageRoute(builder: (context) {
        final Store<int> store = Store<int>(reducer, initialState: 0);
        return ReduxCounterApp(store);
      });

      break;

    case SHOW_CODE_FILE:
      final ScreenArguments screenArgs = routeSettings.arguments;

      return MaterialPageRoute(
          builder: (context) => CodeFileWidget(
                pageName: screenArgs.pageName,
                recipeName: screenArgs.recipeName,
                codeFilePath: screenArgs.codeFilePath,
                codeGithubPath: screenArgs.codeGithubPath,
              ));
      break;

    default:
      return MaterialPageRoute(builder: (context) => UnknownView());
  }
}
