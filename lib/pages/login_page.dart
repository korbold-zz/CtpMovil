import 'package:ctp1/Providers/login_prov.dart';
import 'package:ctp1/behavior/scrollBeahavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email;
  TextEditingController _pswd;
  final _formKey = GlobalKey<FormState>();
  final _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _pswd = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _email.dispose();
    _pswd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        actions: <Widget>[],
        title: Text(
          'Login CTP',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollConfiguration(
                behavior: HiddenScroll(),
                child: buildForm(),
              ),
            ),
          ),
        ),
      ),
      // persistentFooterButtons: <Widget>[],
    );
  }

  buildForm() {
    final user = Provider.of<UserRepository>(context);
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          FlutterLogo(size: 150),
          TextFormField(
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Correo Electrónico:',
              labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 20),

              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return 'Por favor Ingrese el Correo';
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _pswd,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 20),
              labelText: 'Contraseña',
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return 'Por favor Ingrese la Contraseña';
              } else {
                return null;
              }
            },
          ),
          user.status == Status.Authenticating
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  )),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 16.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (!await user.signIn(_email.text, _pswd.text))
                            _scaffolKey.currentState.showSnackBar(SnackBar(
                              content: Text("Correo y Contraseña no existe."),
                            ));
                        }
                      },
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
