import 'package:ctp1/pages/pages_tabs/page_1.dart';
import 'package:ctp1/pages/pages_tabs/page_2.dart';
import 'package:ctp1/pages/pages_tabs/page_3.dart';
import 'package:flutter/material.dart';

class MainTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: <Widget>[
              Page1Tab(),
              Page2Tab(),
              Page3Tab(),
            ],
          ),
          bottomNavigationBar: PreferredSize(
              child: Container(
                height: 60,
                child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.list),
                      text: 'Lista',
                    ),
                    Tab(
                      icon: Icon(Icons.local_activity),
                      text: 'Lista2',
                    ),
                    Tab(
                      icon: Icon(Icons.local_atm),
                      text: 'Lista3',
                    ),
                  ],
                  labelColor: Theme.of(context).primaryColor,
                  labelStyle: TextStyle(fontSize: 10),
                ),
              ),
              preferredSize: Size(60, 60)),
        ),
      ),
    );
  }
}
