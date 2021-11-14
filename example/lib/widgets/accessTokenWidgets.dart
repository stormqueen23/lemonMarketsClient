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
    bool hasToken = context.watch<LemonMarketsProvider>().token != null;
    bool showToken = context.watch<LemonMarketsProvider>().showTokenData;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(
                      () {
                    loadingToken = true;
                  },
                );
                context.read<LemonMarketsProvider>().requestToken(context).then(
                      (value) => setState(
                        () {
                      loadingToken = false;
                    },
                  ),
                );
              },
              child: Text('Request token'),
            ),
            TextButton(
              onPressed: hasToken ? () => context.read<LemonMarketsProvider>().switchShowTokenData() : null,
              child: Text(showToken ? 'Hide token details' : 'Show token details'),
            )
          ],
        ),
        loadingToken
            ? Center(child: CircularProgressIndicator())
            : hasToken && showToken
            ? AccessTokenInfoWidget(
          token: context.watch<LemonMarketsProvider>().token!,
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
        AttributeWidget(name: 'Type: ',value: token.type),
        Divider(),

      ],
    );
  }

}