import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:example/screens/instrumentDetailScreen.dart';
import 'package:example/widgets/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class SearchInstrumentsArea extends StatefulWidget {
  const SearchInstrumentsArea({Key? key}) : super(key: key);

  @override
  _SearchInstrumentsAreaState createState() => _SearchInstrumentsAreaState();
}

class _SearchInstrumentsAreaState extends State<SearchInstrumentsArea> {
  bool loadingInstruments = false;
  ResultList<Instrument>? result;

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
    return Column(
      children: [
        LemonErrorWidget(),
        Text('Instrument search', textScaleFactor: 1.2,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: TextField(
              controller: _controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                  hintText: 'Search stock, fund,...',
                  suffixIcon: focusNode.hasFocus
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _controller.text = "";
                            });
                            context.read<LemonMarketsProvider>().setSearchString("");
                            FocusScope.of(context).unfocus();
                          })
                      : Container(
                          width: 0,
                        )),
              onChanged: (value) {
                context.read<LemonMarketsProvider>().setSearchString(value);
              },
            ),
          ),
          TextButton(
            onPressed: () {
                    setState(
                      () {
                        loadingInstruments = true;
                      },
                    );
                    context.read<LemonMarketsProvider>().searchInstruments().then(
                          (value) => setState(
                            () {
                              result = value;
                              loadingInstruments = false;
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        );
                  },
            child: Text('Search'),
          ),
        ]),
        loadingInstruments
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            )
            : InstrumentListWidget(
                instruments: result,
              ),
      ],
    );
  }
}

class InstrumentListWidget extends StatelessWidget {
  final ResultList<Instrument>? instruments;

  InstrumentListWidget({Key? key, this.instruments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return instruments != null
        ? ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: _getAllInstruments(context),
          )
        : Container();
  }

  List<Card> _getAllInstruments(BuildContext context) {
    List<Card> result = [];
    instruments!.result.forEach((element) {
      String headerText = element.title.isNotEmpty ? element.title : element.name;
      ListTile tile = ListTile(
        title: Text('$headerText'),
        subtitle: Text('${element.isin}'),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InstrumentDetailScreen(instrument: element)),
        ),
      );
      result.add(Card(child: tile));
    });
    return result;
  }
}
