import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LemonErrorWidget extends StatelessWidget {
  const LemonErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasError = context.watch<LemonMarketsProvider>().errorMessage != null;
    return hasError ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(context.watch<LemonMarketsProvider>().errorMessage!, style: TextStyle(color: Colors.red)),
    ) : Container();
  }
}
