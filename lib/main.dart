import 'package:ctp1/Providers/datos_prov.dart';
import 'package:ctp1/Providers/login_prov.dart';
import 'package:ctp1/pages/login_page.dart';
import 'package:ctp1/pages/mainTabs_page.dart';
import 'package:ctp1/routes/routes.dart';
import 'package:ctp1/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _rootPage = LoginPage();
  // Future getSession() async => await FirebaseAuth.instance.currentUser() == null
  //     ? MainTabsPage()
  //     : LoginPage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserRepository>(
      create: (_) => UserRepository.instance(),
      child: MaterialApp(
        theme: tema(),
        home: HomePage(),
        routes: getRutas(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRepository.instance()),
        ChangeNotifierProvider(create: (_) => CRUDModel()),
      ],
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
              return LoginPage();
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return MainTabsPage();
          }
        },
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Image(
          image: AssetImage('Assets/img.jpg'),
          height: 600,
          width: 500,
        ),
      ),
    );
  }
}
