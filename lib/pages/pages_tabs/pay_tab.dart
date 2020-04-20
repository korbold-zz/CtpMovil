import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/Providers/datosCliente_prov.dart';
import 'package:ctp1/Providers/datos_prov.dart';
import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:ctp1/core/Models/pagos_model.dart';
import 'package:ctp1/widget/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayTab extends StatefulWidget {
  final ValueNotifier<double> valor;
  


  const PayTab({Key key, this.valor}) : super(key: key);

  @override
  _PayTabState createState() => _PayTabState();
}

 



class _PayTabState extends State<PayTab> {
  final _formKey = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
    var edit = TextEditingController();
    final datosCliente = Provider.of<DatosClienteProv>(context, listen: false);
    final clienteProv = Provider.of<ClientesProv>(context, listen: false);
    List<PagosModel> pagos;
    return Scaffold(
      body: Column(
        children: <Widget>[
          _pago(datosCliente,  edit),
          Expanded(
            child: StreamBuilder(
                stream: clienteProv.getPagosById(datosCliente.id),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    pagos = snapshot.data.documents
                        .map((doc) => PagosModel.fromMap(doc.data, doc.documentID))
                        .toList();
                    return ListView.builder(
                        itemCount: pagos.length,
                        itemBuilder: (buildContext, index) =>
                            _listTipo1(datosPago: pagos[index], datosCliente: datosCliente, index:index));
                  } else {
                    return Text('cargando....');
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.payment,
            size: 40,
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              clienteProv.addPago(
                  PagosModel(
                      cantidad: num.parse(edit.value.text),
                      fecha: Timestamp.now(),
                      saldo:
                          (datosCliente.valor - num.parse(edit.value.text))),
                  datosCliente.id);
                  clienteProv.updatePago(ClientesModel(saldo:(datosCliente.valor - double.parse(edit.value.text))), datosCliente.id);
                  datosCliente.setValor((datosCliente.valor - double.parse(edit.value.text)));
                  edit.clear();
            }else{
              
            }
            
          }),
    );
  }

  Widget _pago(
    DatosClienteProv datosCliente,
    TextEditingController edit,
  ) {
    ValueNotifier valueNotifier = ValueNotifier(0.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Form(
        key: _formKey,
        child: Container(
          height: 120,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Por favor ingrese la Cantidad';
                  } else if( double.parse(edit.value.text) > datosCliente.valor){
                    
                    return 'El valor ${edit.value.text} es mayor';
                    
                  }else if(double.parse(edit.value.text)<=0){
                    return 'EL VALOR DEBER SER MAYOR A 0';
                  }else{
                    return null;
                  }
                  
                },
                onChanged: (text) {
                  valueNotifier.value = (text.isEmpty ? 0 : num.parse(text));
                },
                
                controller: edit,
                style: TextStyle(fontSize: 50),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder:
                        (BuildContext context, dynamic value, Widget child) {
                      return Text(' ${(datosCliente.valor - value)}' ,style: TextStyle(fontSize: 40),);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTipo1({PagosModel datosPago ,DatosClienteProv datosCliente, int index}) {
    TextStyle estiloLetras =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 40);
    
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      color: (index==0?Colors.amberAccent:Colors.white),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.monetization_on,
              color: Colors.green,
              size: 50,
            ),
            title: Text(
              '${datosPago.saldo.toString()}',
              style: estiloLetras,
            ),
            subtitle: Text(
              'Pago: ${datosPago.cantidad.toString()}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[600],
                  fontWeight: FontWeight.bold),
            ),
            trailing: (0==index? Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              color: Colors.red,
              child: FlatButton(
                  onPressed: () {
                     _mostrarAlerta(context, datosCliente, datosPago);

                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 35,
                  )),
            ):Text('')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('FECHA DE PAGO: ${datosPago.fecha.toDate().toString()}',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }


  _mostrarAlerta(BuildContext context,DatosClienteProv datosCliente,PagosModel datosPago) {
    final clienteProv = Provider.of<ClientesProv>(context, listen: false);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('¿Estás seguro de eliminar el pago de ${datosPago.cantidad} dólares?'),
            
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              FlatButton(
                  onPressed: (){
                    clienteProv.removePago(datosCliente.id, datosPago.id);
                    datosCliente.setValor((datosCliente.valor+datosPago.cantidad));
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
