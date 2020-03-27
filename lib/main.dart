import 'package:ctp1/pages/login_page.dart';
import 'package:ctp1/pages/mainTabs_page.dart';
import 'package:ctp1/routes/routes.dart';
import 'package:ctp1/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _rootPage = LoginPage();
  Future getSession() async => await FirebaseAuth.instance.currentUser() == null
      ? MainTabsPage()
      : LoginPage();

  @override
  void initState() {
    super.initState();
    getSession().then((page) {
      setState(() {
        _rootPage = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: tema(),
      // home: _rootPage,
      initialRoute: '/',
      routes: getRutas(),
    );
  }
}
