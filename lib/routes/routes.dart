

import 'package:ctp1/pages/login_page.dart';
import 'package:ctp1/pages/mainTabs_page.dart';
import 'package:ctp1/pages/pages_tabs/page_1.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRutas() {
  return <String, WidgetBuilder>{
    // '/': (context)=> Placeholder(),
    '/login': (context) => LoginPage(),
    '/maintabs': (context) => MainTabsPage(),
    '/rutascodigo': (context) => Page1Tab()
  };
}
