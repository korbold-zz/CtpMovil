import 'package:ctp1/Providers/login_prov.dart';

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
      backgroundColor: Color.fromARGB(255, 197, 66, 65),
      key: _scaffolKey,
      // appBar: AppBar(

      //   actions: <Widget>[],
      //   title: Text(
      //     'Cristo Tiene Poder',
      //     style: TextStyle(color: Colors.blue, ),
      //   ),
      //   backgroundColor: Colors.amberAccent,
      // ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              SizedBox(height: 10),
              buildForm()
            ],
          ),
        ),
      ),

      // persistentFooterButtons: <Widget>[],
    );
  }

  buildForm() {
    final user = Provider.of<UserRepository>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image(
                image: AssetImage('Assets/logo.png'),
                height: 150,
                width: 150,
              ),
              TextFormField(
                controller: _email,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                
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
                height: 5,
              ),
              TextFormField(
                controller: _pswd,
                obscureText: true,
                autocorrect: false,

                textInputAction: TextInputAction.done,
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
                        vertical: 14,
                      ),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blue,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (!await user.signIn(_email.text, _pswd.text))
                                _scaffolKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text("Correo y Contraseña no existe."),
                                ));
                            }
                          },
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
