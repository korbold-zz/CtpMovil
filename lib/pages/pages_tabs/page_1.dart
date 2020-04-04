import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/Providers/datos_prov.dart';

import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cliente_page.dart';

class Page1Tab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientesProvider = Provider.of<ClientesProv>(context, listen: false);
    List<ClientesModel> clientes;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta: ${clientesProvider.getNombreLugar()}'),
      ),
      body: Container(
        child: StreamBuilder(
            stream: clientesProvider.lugarCodigo(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                clientes = snapshot.data.documents
                    .map((doc) => ClientesModel.fromMap(doc.data))
                    .toList();
                return ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (buildContext, index) =>
                      _listTipo1(clientesDetails: clientes[index], context:context),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
    );
  }

  Widget _listTipo1({ClientesModel clientesDetails, BuildContext context}) {
    TextStyle estiloLetras = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              clientesDetails.codigo.toString(),
              style: estiloLetras,
            ),
            title: Text(clientesDetails.nombreCompleto, style: estiloLetras,),
            // subtitle: Text(clientesDetails.fechaSig),
            trailing: Text(clientesDetails.fechaSig),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // FlatButton(
              //   onPressed: () {},
              //   child: Text(
              //     'Cancelar',
              //     style: TextStyle(
              //       color: Colors.blue,
              //     ),
              //   ),
              // ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new ClientePage(),
              ),
            );
                },
                child: Text(
                  'Ver Detalles',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
