import 'package:cloud_firestore/cloud_firestore.dart';

class PagosModel {
  String id;
  num cantidad;
  Timestamp fecha;
  num saldo;

  PagosModel({this.id,this.cantidad, this.fecha, this.saldo});

  PagosModel.fromMap(Map snapshot, String id)
      : id = id ?? '', 
      cantidad = snapshot['VALOR'] ?? '',
        fecha = snapshot['FECHA_PAGO'] ?? '',
        saldo = snapshot['SALDO'] ?? '';
  toJson() {
    return {
      
      "VALOR": cantidad,
      "SALDO": saldo,
      "FECHA_PAGO": fecha,
    };
  }
}
