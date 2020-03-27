import 'package:ctp1/behavior/scrollBeahavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffolKey = GlobalKey<ScaffoldState>();

  String _email, _pswd;
  bool _isLoginIn = false;

  _login() async {
    if (_isLoginIn) {
      return;
    }
    setState(() => _isLoginIn = true);

    final form = _formKey.currentState;
    if (!form.validate()) {
      _scaffolKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isLoginIn = false;
      });
      return;
    }
    form.save();
    try {
      final resp = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _pswd);

      _scaffolKey.currentState.showSnackBar(SnackBar(
        content: Text('Iniciando Sesión.....'),
      ));

      print('RESULTADO-------' + resp.toString());
      Navigator.of(context).pushReplacementNamed('/maintabs');
    } catch (e) {
      _scaffolKey.currentState.hideCurrentSnackBar();
      _scaffolKey.currentState.showSnackBar(SnackBar(
          content: Text('Usuario y Contraseña no existe.'),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Aceptar',
            onPressed: () {
              _scaffolKey.currentState.hideCurrentSnackBar();
            },
          )));
    } finally {
      setState(() {
        _isLoginIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        title: Text(
          'Login CTP',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _login();
        },
        child: Icon(Icons.send),
      ),
      persistentFooterButtons: <Widget>[],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          FlutterLogo(size: 150),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Usuario:',
              labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 20),

              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return 'Por favor Ingrese el Usuario';
              } else {
                return null;
              }
            },
            onSaved: (val) {
              setState(() {
                _email = val;
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
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
            onSaved: (val) {
              setState(() {
                _pswd = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
