import 'package:flutter/material.dart';
import 'package:flutterpatterns/counter_app/vanilla.dart';
import 'package:flutterpatterns/screen_args.dart';

import 'codefile.dart';
import 'counter_app/value_notifier.dart';
import 'home.dart';
import 'unknown.dart';

const String HOME = "/";
const String SHOW_CODE_FILE = 'SHOW_CODE_FILE';
const String VANILLA_COUNTER_APP = 'VANILLA_COUNTER_APP';
const String VALUE_NOTIFIER_COUNTER_APP = 'VALUE_NOTIFIER_COUNTER_APP';

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
