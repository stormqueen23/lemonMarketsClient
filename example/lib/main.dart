import 'package:example/widgets/accessTokenWidgets.dart';
import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:example/widgets/searchInstrumentsWidgets.dart';
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

class LemonMarketsExample extends StatefulWidget {
  LemonMarketsExample({Key? key}) : super(key: key);

  @override
  _LemonMarketsExampleState createState() => _LemonMarketsExampleState();
}

class _LemonMarketsExampleState extends State<LemonMarketsExample> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lemon Markets Demo'),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ErrorWidget(),
                AccessTokenRow(),
                AccessTokenArea(),
                SearchInstrumentsArea()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasError = context.watch<LemonMarketsProvider>().errorMessage != null;
    return hasError ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(context.watch<LemonMarketsProvider>().errorMessage!, style: TextStyle(color: Colors.red)),
    ) : Container();
  }
}


class AccessTokenRow extends StatelessWidget {
  const AccessTokenRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasToken = context.watch<LemonMarketsProvider>().token != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Token: '),
        hasToken
            ? Icon(
          Icons.check_box,
          color: Colors.green,
        )
            : Icon(
          Icons.not_interested,
          color: Colors.red,
        )
      ],
    );
  }
}

