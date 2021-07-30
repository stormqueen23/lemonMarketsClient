import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:flutter/material.dart';
import 'package:lemon_markets_client/data/resultList.dart';
import 'package:lemon_markets_client/helper/lemonMarketsConverter.dart';
import 'package:provider/provider.dart';
import 'package:lemon_markets_client/lemon_markets_client.dart';

class SpacesArea extends StatefulWidget {
  const SpacesArea({Key? key}) : super(key: key);

  @override
  _SpacesAreaState createState() => _SpacesAreaState();
}

class _SpacesAreaState extends State<SpacesArea> {
  bool loadingSpaces = false;

  @override
  Widget build(BuildContext context) {
    bool hasToken = context.watch<LemonMarketsProvider>().token != null;
    bool showData = context.watch<LemonMarketsProvider>().showSpaceData;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(
                  () {
                    loadingSpaces = true;
                  },
                );
                context.read<LemonMarketsProvider>().requestSpaceDetails().then(
                      (value) => setState(
                        () {
                          loadingSpaces = false;
                        },
                      ),
                    );
              },
              child: Text('Request space details'),
            ),
            TextButton(
              onPressed: hasToken ? () => context.read<LemonMarketsProvider>().switchShowSpaceData() : null,
              child: Text(showData ? 'Hide space details' : 'Show space details'),
            )
          ],
        ),
        loadingSpaces
            ? Center(child: CircularProgressIndicator())
            : hasToken && showData
                ? SpacesInfoWidget(
          spaces: context.watch<LemonMarketsProvider>().spaces!,
                  )
                : Container(),
      ],
    );
  }
}

class SpacesInfoWidget extends StatelessWidget {
  final ResultList<Space> spaces;

  SpacesInfoWidget({Key? key, required this.spaces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView (
      shrinkWrap: true,
      children: _createSpaces(),
    );
  }

  List<Widget> _createSpaces() {
    return spaces.result.map((e) => _createSpace(e)).toList();
  }

  Widget _createSpace(Space space) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Space data:')],
        ),
        Divider(),
        _createRow('Name: ', space.name),
        Divider(),
        _createRow('Type: ', space.type),
        Divider(),
        _createRow('Uuid: ', space.uuid),
        Divider(),
        _createRow('Cash to invest: ', space.state.cashToInvest),
        Divider(),
        _createRow('Balance: ', space.state.balance),
      ],
    );
  }

  Row _createRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label)),
        Flexible(flex: 4, child: SelectableText(value)),
      ],
    );
  }
}

class SpaceDetailRow extends StatelessWidget {
  const SpaceDetailRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasData = context.watch<LemonMarketsProvider>().spaces != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Space details: '),
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