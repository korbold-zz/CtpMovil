import 'package:ctp1/Providers/login_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget PDawer(BuildContext context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          curve: Curves.fastOutSlowIn,
          child: Text('Drawer Header'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Cerrar Sesión'),
          onTap: () {
            signOut(context);
            // Navigator.of(context).popAndPushNamed('/login');
            // ...
          },
        ),
      ],
    ),
  );
}

Future<void> signOut(BuildContext context) async {
  try {
    final signOut = Provider.of<UserRepository>(context, listen: false);
    await signOut.signOut();
    print('--------------------------EXITO SALIR-----------------');
  } catch (e) {
    print('-----------------RESULTADO ERROR-----------------' + e.toString());
  }
}
