import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:flutter/material.dart';
import 'package:lemon_markets_client/data/resultList.dart';
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
    bool hasToken = context.watch<LemonMarketsProvider>().token != null;
    return Column(
      children: [
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
            onPressed: !hasToken
                ? null
                : () {
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
            ? Center(child: CircularProgressIndicator())
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
            children: _getAllInstruments(),
          )
        : Container();
  }

  List<Card> _getAllInstruments() {
    List<Card> result = [];
    instruments!.result.forEach((element) {
      String headerText = element.title.isNotEmpty ? element.title : element.name;
      ListTile tile = ListTile(
        //leading: Text('${element.name}'),
        title: Text('$headerText'),
        subtitle: Text('${element.isin}'),
        onTap: null, //() => AppRouter.router.navigateTo(context, 'instrument/${element.isin}'),
      );
      result.add(Card(child: tile));
    });
    return result;
  }
}
