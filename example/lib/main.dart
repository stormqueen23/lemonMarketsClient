import 'package:example/screens/homeScreen.dart';
import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  //logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName} [${record.level.name}]: ${record.time}: ${record.message}');
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LemonMarketsProvider()),
      ],
      child: LemonMarketsExample(),
    ),
  );
}

class LemonMarketsExample extends StatelessWidget {
  LemonMarketsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}