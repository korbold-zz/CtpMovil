import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:ctp1/Providers/datos_prov.dart';

import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:ctp1/pages/cliente_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    .map((doc) => ClientesModel.fromMap(doc.data, doc.documentID))
                    .toList();
                return ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (buildContext, index) => _listTipo1(
                      clientesDetails: clientes[index], context: context),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
    );
  }

  Widget _listTipo1({ClientesModel clientesDetails, BuildContext context}) {
    TextStyle estiloLetras =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);

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
            title: Text(
              clientesDetails.nombreCompleto,
              style: estiloLetras,
            ),
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
                  datosCliente.setNombreCliente(clientesDetails.nombreCompleto);
                  datosCliente.setCelular(clientesDetails.celular);
                  datosCliente.setTelefono(clientesDetails.telefono);
                  datosCliente.setValor(clientesDetails.saldo);
                  datosCliente.setIdCliente(clientesDetails.id);
                  datosCliente.setFechaSig(clientesDetails.fechaSig);
                  datosCliente.setCodCliente(clientesDetails.codigo);
                  // datosCliente.setDireccion(clientesDetails.);

                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new ClienteTab(),
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
