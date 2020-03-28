import 'package:ctp1/pages/pages_tabs/drawer.dart';
import 'package:ctp1/pages/pages_tabs/page_1.dart';
import 'package:ctp1/pages/pages_tabs/page_2.dart';
import 'package:ctp1/pages/pages_tabs/page_3.dart';
import 'package:flutter/material.dart';

class MainTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
          drawer: PDawer(context),
        ),
      ),
      
    );
  }
}
