import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:ctp1/Providers/datos_prov.dart';
import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  final _scaffolKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    return Scaffold(
      key: _scaffolKey,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Información Personal',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status
                                          ? _getEditIcon()
                                          : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          LabelEtiqueta(
                            nombre: 'Nombre Completo',
                          ),
                          EditConcepto(
                              datosCliente: datosCliente, status: _status),
                          Row(
                            children: <Widget>[
                              _buton(
                                  nombre: 'Celular',
                                  numeroContacto: datosCliente.celular),
                              SizedBox(
                                width: 40,
                              ),
                              _buton(
                                  nombre: 'Teléfono',
                                  numeroContacto: datosCliente.telefono),
                            ],
                          ),
                          LabelContactos(),
                          EditContactos(status: _status),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buton({String numeroContacto, String nombre}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 50, top: 12),
      child: SizedBox.fromSize(
        size: Size(70, 70), // button width and height
        child: ClipOval(
          child: Material(
            color: Color.fromARGB(255, 69, 74, 114), // button color
            child: InkWell(
              splashColor: Color.fromARGB(80, 69, 74, 114), // splash color
              onTap: () =>
                  UrlLauncher.launch('tel:$numeroContacto'), // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ), // icon
                  Text(
                    nombre,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ), // text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    final clientesDatos = Provider.of<ClientesProv>(context, listen: false);
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Guardar"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  try {
                    _formKey.currentState.save();
                    
                    await clientesDatos.updateDatosCliente(
                        ClientesModel(
                            nombreCompleto: datosCliente.getNombreCliente,
                            celular: datosCliente.getCelular,
                            telefono: datosCliente.telefono),
                        datosCliente.idCliente);

                    FocusScope.of(context).requestFocus(new FocusNode());
                    setState(() {
                      _status = true;
                    });
                    _scaffolKey.currentState.showSnackBar(SnackBar(
                      content: Text("Datos Guardados."),
                    ));
                  } catch (e) {
                    _scaffolKey.currentState.showSnackBar(SnackBar(
                      content: Text("No se han Guardado los datos."),
                    ));
                  }
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancelar"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 19.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 20.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}

class EditContactos extends StatelessWidget {
  const EditContactos({
    Key key,
    @required bool status,
  })  : _status = status,
        super(key: key);

  final bool _status;

  @override
  Widget build(BuildContext context) {
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: new TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: datosCliente.celular,
                onSaved: (value) => datosCliente.setCelular(value),
                // controller: editCelular,
                decoration: const InputDecoration(hintText: "Ej. 0999280399"),
                enabled: !_status,
              ),
            ),
            flex: 2,
          ),
          Flexible(
            child: new TextFormField(
              keyboardType: TextInputType.phone,
              initialValue: datosCliente.telefono,
              onSaved: (value) => datosCliente.setTelefono(value),
              decoration: const InputDecoration(hintText: "Ej. 062669123"),
              enabled: !_status,
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class LabelContactos extends StatelessWidget {
  const LabelContactos({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: new Text(
                  'Celular',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                child: new Text(
                  'Teléfono',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              flex: 2,
            ),
          ],
        ));
  }
}

class EditConcepto extends StatelessWidget {
  const EditConcepto({
    Key key,
    @required this.datosCliente,
    @required bool status,
  })  : _status = status,
        super(key: key);

  final DatosClienteProv datosCliente;
  final bool _status;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Flexible(
              child: new TextFormField(
                initialValue: datosCliente.nombreCliente,
                onSaved: (value) => datosCliente.setNombreCliente(value),
                decoration: const InputDecoration(
                  hintText: "Ej. Jacinto Emerson Yar Yépez",
                ),
                enabled: !_status,
                autofocus: !_status,
              ),
            ),
          ],
        ));
  }
}

class LabelEtiqueta extends StatelessWidget {
  final String nombre;
  const LabelEtiqueta({Key key, this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  nombre,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }
}
