import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:example/widgets/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class OrderScreen extends StatefulWidget {
  final bool sell;
  final Instrument instrument;

  const OrderScreen({Key? key, required this.instrument, required this.sell}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create buy order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LemonErrorWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    widget.instrument.title,
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(widget.instrument.isin)],
                ),
              ),
              context.watch<LemonMarketsProvider>().orderCreated
                  ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        'Buy-order created and activated',
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green),
                      ),
                  )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuantityInputWidget(),
                    ),
              context.watch<LemonMarketsProvider>().orderCreated
                  ? Container()
                  : TextButton(
                      onPressed: loading || context.watch<LemonMarketsProvider>().quantity == null
                          ? null
                          : () {
                              setState(() {
                                loading = true;
                              });
                              context.read<LemonMarketsProvider>().createAndActivateOrder(widget.instrument.isin, false).then((value) => setState(() {
                                    loading = false;
                                  }));
                            },
                      child: Text('Create and activate order'))
            ],
          ),
        ),
      ),
    );
  }
}

class QuantityInputWidget extends StatefulWidget {
  const QuantityInputWidget({Key? key}) : super(key: key);

  @override
  _QuantityInputWidgetState createState() => _QuantityInputWidgetState();
}

class _QuantityInputWidgetState extends State<QuantityInputWidget> {
  TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: _controller,
        focusNode: focusNode,
        decoration: InputDecoration(
            hintText: 'Enter quantity',
            suffixIcon: focusNode.hasFocus
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _controller.text = "";
                      });
                      context.read<LemonMarketsProvider>().setQuantity(null);
                      FocusScope.of(context).unfocus();
                    })
                : Container(
                    width: 0,
                  )),
        onChanged: (value) {
          context.read<LemonMarketsProvider>().setQuantity(value);
        },
      ),
    );
  }
}
