import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:example/screens/orderScreen.dart';
import 'package:example/widgets/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class InstrumentDetailScreen extends StatelessWidget {
  final Instrument instrument;

  const InstrumentDetailScreen({Key? key, required this.instrument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasSpaceData = context.watch<LemonMarketsProvider>().spaces != null &&
        context.watch<LemonMarketsProvider>().spaces!.result.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(instrument.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AttributeWidget(name: 'Name: ', value: instrument.name),
            AttributeWidget(name: 'Type: ', value: instrument.type),
            AttributeWidget(name: 'Isin: ', value: instrument.isin),
            AttributeWidget(name: 'WKN: ', value: instrument.wkn),
            AttributeWidget(name: 'Symbol: ', value: instrument.symbol),
            Container(
              height: 16,
            ),
            !hasSpaceData
                ? Text(
                    'You can only create an order if you have requested space details',
                    textScaleFactor: 0.8,
                  )
                : Container(),
            TextButton(
                onPressed: () {
                  context.read<LemonMarketsProvider>().orderCreated = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderScreen(instrument: instrument, sell: false)),
                  );
                },
                child: Text('Create buy order'))
          ],
        ),
      ),
    );
  }
}
