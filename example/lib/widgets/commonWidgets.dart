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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () => context.read<LemonMarketsProvider>().setErrorMessage(null), icon: Icon(Icons.clear, color: Colors.red,)),
            ],
          ),
          Text(context.watch<LemonMarketsProvider>().errorMessage!, style: TextStyle(color: Colors.red)),
        ],
      ),
    ) : Container();
  }
}

class AttributeWidget extends StatelessWidget {
  final String name;
  final String value;

  const AttributeWidget({Key? key, required this.name, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(name)),
        Flexible(child: SelectableText(value))
      ],
    );
  }
}

class DataReceivedWidget extends StatelessWidget {
  final bool hasData;
  final String description;

  const DataReceivedWidget({Key? key,required this.hasData,required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(description),
        hasData
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


