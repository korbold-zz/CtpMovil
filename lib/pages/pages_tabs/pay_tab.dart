import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:ctp1/Providers/datos_prov.dart';
import 'package:ctp1/core/Models/pagos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayTab extends StatelessWidget {
  final ValueNotifier<double> valor;

  const PayTab({Key key, this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var edit = TextEditingController();
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    final clienteProv = Provider.of<ClientesProv>(context, listen: false);
    List<PagosModel> pagos;
    return Scaffold(
      body:

          // _pago(datosCliente, edit),
          StreamBuilder(
              stream: clienteProv.getPagosById(datosCliente.id),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  pagos = snapshot.data.documents
                      .map((doc) => PagosModel.fromMap(doc.data))
                      .toList();
                  return ListView.builder(
                      itemCount: pagos.length,
                      itemBuilder: (buildContext, index) =>
                          _listTipo1(datosPago: pagos[index]));
                } else {
                  return Text('cargando....');
                }
              }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.monetization_on),
        onPressed: () {
          clienteProv.addPago(
              PagosModel(
                  cantidad: num.parse(edit.value.text),
                  fecha: Timestamp.now(),
                  saldo: (datosCliente.valor - double.parse(edit.value.text))),
              datosCliente.id);
        },
      ),
    );
  }

  Widget _pago(DatosClienteProv datosCliente, TextEditingController edit) {
    ValueNotifier valueNotifier = ValueNotifier(0.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        height: 100,
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (text) {
                valueNotifier.value = (text.isEmpty ? 0 : double.parse(text));
              },
              controller: edit,
              style: TextStyle(fontSize: 50),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffix: ValueListenableBuilder(
                  valueListenable: valueNotifier,
                  builder: (BuildContext context, dynamic value, Widget child) {
                    return Text('# ${datosCliente.valor - value}');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTipo1({PagosModel datosPago}) {
    TextStyle estiloLetras =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 40);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.monetization_on,
              color: Colors.green,
            ),
            title: Text(
              datosPago.saldo.toString(),
              style: estiloLetras,
            ),
            subtitle: Text(datosPago.fecha.toDate().toString()),
            trailing: FlatButton(onPressed: () {}, child: Icon(Icons.delete)),
          ),
        ],
      ),
    );
  }
}
