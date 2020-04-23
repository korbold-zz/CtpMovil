import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:ctp1/Providers/datos_prov.dart';
import 'package:ctp1/Providers/login_prov.dart';
import 'package:ctp1/Providers/lugares_prov.dart';
import 'package:ctp1/Providers/usuarios_prov.dart';

import 'package:ctp1/pages/login_page.dart';
import 'package:ctp1/pages/mainTabs_page.dart';
import 'package:ctp1/routes/routes.dart';
import 'package:ctp1/themes/themes.dart';
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
        localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en'), // English
    const Locale('es'), // Hebrew
    const Locale.fromSubtags(languageCode: 'es'), // Chinese *See Advanced Locales below*
    // ... other locales the app supports
  ],


        initialRoute: '/',
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
        ChangeNotifierProvider(create: (_) => ClientesProv()),
        ChangeNotifierProvider(create: (_) => LugaresProv()),
        ChangeNotifierProvider(create: (_) => UsuariosProv()),
        ChangeNotifierProvider(create: (_) => DatosClienteProv()),
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
