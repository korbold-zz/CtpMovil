import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/Providers/datos_prov.dart';
import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Page1Tab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context, listen: false);
    List<ClientesModel> clientes;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                clientes = snapshot.data.documents
                    .map((doc) => ClientesModel.fromMap(doc.data))
                    .toList();
                return ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (buildContext, index) =>
                      _listTipo1(clientesDetails: clientes[index]),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
    
    );
  }

  Widget _listTipo1({ClientesModel clientesDetails}) {
    return Card(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(clientesDetails.codigo.toString()),
            title: Text(clientesDetails.nombreCompleto),
            subtitle: Text(clientesDetails.cobrador),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
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