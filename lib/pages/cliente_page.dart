import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: _usuario(),
      ),
    );
  }

  _usuario() {
        final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    return Consumer<DatosClienteProv>(
      builder: (context, DatosClienteProv value,__) {
          return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _textoDatos(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      _buton(celular: datosCliente.celular),
                      SizedBox(
                        width: 40,
                      ),
                      _buton(),
                    ],
                  ),
                   _textoDatos2(),
                  SizedBox(
                        height: 15,
                      ),
                   _textoDatos1(),
                ],
              )
            ],
          ),
        ),
      ); 
      },
    );
  }

  Container _textoDatos() {
        final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 197, 66, 65),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      offset: new Offset(1, 45),
                    ),
                  ],
                ),
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        datosCliente.getNombreCliente,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
  }
  Container _textoDatos2() {
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 69, 74, 114),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      offset: new Offset(1, 45),
                    ),
                  ],
                ),
                height:40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Siguiente Visita: 20/03/2020',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
  }
   Container _textoDatos1() {
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 197, 66, 65),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      offset: new Offset(1, 10),
                    ),
                  ],
                ),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Dirección:', style: TextStyle(fontSize: 20, ),),
                      Text(
                        'Enim exercitation anim labore cillum Lorem adipisicing aliquip pariatur ut occaecat magna dolore cillum.',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
  }

  _buton({String celular}) {
    return SizedBox.fromSize(
      size: Size(60, 60), // button width and height
      child: ClipOval(
        child: Material(
          color: Color.fromARGB(255, 69, 74, 114), // button color
          child: InkWell(
            splashColor: Color.fromARGB(80, 69, 74, 114), // splash color
            onTap: () => UrlLauncher.launch('tel:$celular'), // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.call,
                  color: Colors.white,
                ), // icon
                Text(
                  "Celular",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ), // text
              ],
            ),
          ),
        ),
      ),
    );
  }
}
