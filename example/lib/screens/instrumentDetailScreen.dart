import 'package:flutter/material.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class InstrumentDetailScreen extends StatelessWidget {
  final Instrument instrument;

  const InstrumentDetailScreen({Key? key, required this.instrument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(instrument.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _getAttributeRow('Name: ', instrument.name),
            _getAttributeRow('Type: ', instrument.type),
            _getAttributeRow('Isin: ', instrument.isin),
            _getAttributeRow('WKN: ', instrument.wkn),
            _getAttributeRow('Symbol: ', instrument.symbol),
            _getAttributeRow('Currency: ', instrument.currency),
            _getAttributeRow('Tradable: ', instrument.tradable.toString()),
          ],
        ),
      ),
    );
  }

  Widget _getAttributeRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(name)),
          Flexible(flex: 3, child: Text(value))
        ],
      ),
    );
  }
}
