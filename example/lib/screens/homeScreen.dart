import 'package:example/widgets/accessTokenWidgets.dart';
import 'package:example/widgets/commonWidgets.dart';
import 'package:example/widgets/searchInstrumentsWidgets.dart';
import 'package:example/widgets/spaceWidgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lemon Markets Demo'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Main',
              ),
              Tab(
                text: 'Search',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LemonErrorWidget(),
                    AccessTokenRow(),
                    AccessTokenArea(),
                    Divider(
                      thickness: 3,
                    ),
                    SpaceDetailRow(),
                    SpacesArea(),

                  ],
                ),
              ),
            ),
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LemonErrorWidget(),
                      SearchInstrumentsArea(),
                    ],
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
