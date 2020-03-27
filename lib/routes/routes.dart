import 'package:ctp1/pages/login_page.dart';
import 'package:ctp1/pages/mainTabs_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRutas() {
  return <String, WidgetBuilder>{
    '/': (context) => LoginPage(),
    '/maintabs': (context) => MainTabsPage()
  };
}
