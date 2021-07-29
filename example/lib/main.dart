import 'package:example/credentials.dart';
import 'package:flutter/material.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';
import 'package:logging/logging.dart';

void main() {
  //logging
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName} [${record.level.name}]: ${record.time}: ${record.message}');
  });

  runApp(LemonMarketsExample());
}

class LemonMarketsExample extends StatefulWidget {
  LemonMarketsExample({Key? key}) : super(key: key);

  @override
  _LemonMarketsExampleState createState() => _LemonMarketsExampleState();
}

class _LemonMarketsExampleState extends State<LemonMarketsExample> {
  final LemonMarkets lm = LemonMarkets();
  Credentials c = Credentials();

  AccessToken? token;
  bool loadingToken = false;
  String? errorMessageToken;

  StateInfo? stateInfo;
  bool loadingStateInfo = false;

  Future<void> requestToken() async {
    await c.init(context);
    debugPrint(c.clientId);
    debugPrint(c.clientSecret);
    try {
      token = await lm.requestToken(c.clientId, c.clientSecret);
    } on LemonMarketsException catch (e) {
      errorMessageToken = e.toString();
    }
  }

  Future<void> requestStateInfo() async {
    stateInfo = await lm.getStateInfo(token!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lemon Markets Demo'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('Has accessToken: '),
                token != null
                    ? Icon(
                        Icons.check_box,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.not_interested,
                        color: Colors.red,
                      )
              ],
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  loadingToken = true;
                });
                requestToken().then((value) => setState(() {
                      loadingToken = false;
                    }));
              },
              child: Text('Request token'),
            ),
            loadingToken
                ? Center(child: CircularProgressIndicator())
                : token != null
                    ? AccessTokenInfoWidget(
                        token: token!,
                      )
                    : errorMessageToken != null
                        ? Text(
                            errorMessageToken!,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()
          ],
        ),
      ),
    );
  }
}

class AccessTokenInfoWidget extends StatelessWidget {
  final AccessToken token;

  AccessTokenInfoWidget({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Token data:')],
        ),
        Divider(),
        _createRow('Type: ', token.type),
        Divider(),
        _createRow('Scope: ', token.scope),
        Divider(),
        _createRow('Expires: ', token.expiresIn.toString()),
        Divider(),
        _createRow('Expires (date): ', DateTime.now().add(Duration(seconds: token.expiresIn)).toLocal().toString()),
      ],
    );
  }

  Row _createRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label)),
        Flexible(flex: 4, child: Text(value)),
      ],
    );
  }
}
