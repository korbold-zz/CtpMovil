import 'package:cloud_firestore/cloud_firestore.dart';

class PagosModel {
  
  num cantidad;
  Timestamp fecha;
  num saldo;

  PagosModel({this.cantidad, this.fecha, this.saldo});

  PagosModel.fromMap(Map snapshot)
      : cantidad = snapshot['VALOR'] ?? '',
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
