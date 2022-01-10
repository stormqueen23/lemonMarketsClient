import 'package:example/provider/lemonMarketsProvider.dart';
import 'package:example/widgets/commonWidgets.dart';
import 'package:flutter/material.dart';
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
    bool hasToken = true;
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
              onPressed: () => context.read<LemonMarketsProvider>().switchShowSpaceData(),
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
  final TradingResultList<Space> spaces;

  SpacesInfoWidget({Key? key, required this.spaces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView (
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
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
        AttributeWidget(name: 'Name: ',value: space.name),
        Divider(),
         AttributeWidget(name: 'Uuid: ',value: space.uuid),

      ],
    );
  }
}