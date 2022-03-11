import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:example/widgets/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class AccessTokenArea extends StatefulWidget {
  const AccessTokenArea({Key? key}) : super(key: key);

  @override
  _AccessTokenAreaState createState() => _AccessTokenAreaState();
}

class _AccessTokenAreaState extends State<AccessTokenArea> {
  bool loadingToken = false;

  @override
  Widget build(BuildContext context) {
    bool showToken = context.watch<LemonMarketsProvider>().showTokenData;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => context.read<LemonMarketsProvider>().switchShowTokenData(),
              child: Text(showToken ? 'Hide token details' : 'Show token details'),
            )
          ],
        ),
        loadingToken
            ? Center(child: CircularProgressIndicator())
            : showToken
                ? AccessTokenInfoWidget(
                    token: context.watch<LemonMarketsProvider>().token,
                  )
                : Container(),
      ],
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
        AttributeWidget(name: 'Type: ', value: token.type),
        Divider(),
        AttributeWidget(name: 'Token: ', value: token.token),
        Divider(),
        AttributeWidget(name: 'Real Money: ', value: token.realMoneyAccess.toString()),
      ],
    );
  }
}
