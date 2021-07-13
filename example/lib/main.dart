import 'package:flutter/material.dart';
import 'package:lemon_market_client/lemon_market_client.dart';
import 'package:logging/logging.dart';

void main() {
  //logging
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName} [${record.level.name}]: ${record.time}: ${record.message}');
  });

  runApp(LemonMarketExample());
}

class LemonMarketExample extends StatefulWidget {
  LemonMarketExample({Key? key}) : super(key: key);

  @override
  _LemonMarketExampleState createState() => _LemonMarketExampleState();
}

class _LemonMarketExampleState extends State<LemonMarketExample> {
  final LemonMarket market = LemonMarket(failSilent: false);

  final String clientId = "XXX";
  final String clientSecret = "YYY";

  AccessToken? token;
  bool loadingToken = false;
  String? errorMessageToken;

  StateInfo? stateInfo;
  bool loadingStateInfo = false;

  Future<void> requestToken() async {
    try {
      token = await market.requestToken(clientId, clientSecret);
    } on LemonMarketJsonException catch (e) {
      errorMessageToken = e.responseMap.toString();
    }
  }

  Future<void> requestSpace() async {
    stateInfo = await market.getSpaceInfo(token!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lemon Market Demo'),
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
        _createRow('Expires: ', token.expires_in.toString()),
        Divider(),
        _createRow('Expires (date): ', DateTime.now().add(Duration(seconds: token.expires_in)).toLocal().toString()),
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
