import 'package:flutter/material.dart';

class ClientesModel with ChangeNotifier{
  String id;
  int codigo;
  String nombreCompleto;
  String cobrador;
  String nombreRuta;
  String fechaSig;
  String celular;
  String telefono;
  num saldo;
  String direccion;

  ClientesModel(
      {this.nombreCompleto,
      this.cobrador,
      this.codigo,
      this.nombreRuta,
      this.fechaSig,
      this.celular,
      this.telefono, 
      this.saldo, 
      this.id,
      this.direccion});

  ClientesModel.fromMap(Map snapshot, String id)
      :id = id ?? '', 
       codigo = snapshot['CODCLI'] ?? '',
       nombreCompleto = snapshot['NOMCLI'] ?? '',
        nombreRuta = snapshot['ZONA'] ?? '',
        cobrador = snapshot['CODCOB'] ?? '',
        fechaSig =  snapshot['SIGVI'] ?? '',
        celular =  snapshot['CELCLI'] ?? '',
        saldo =  snapshot['SALDOC'] ?? 0,
        telefono =  snapshot['TELCLI'] ?? '';
        
  toJson() {
    return {
      "CODCLI": codigo,
      "NOMCLI": nombreCompleto,
      "CODCOB": cobrador,
      "ZONA": nombreRuta,
      "SIGVI": fechaSig,
      "CELCLI": celular,
      "SALDOC": saldo,
      "TELCLI": telefono,
    };
  }

get nombresCompleto => nombreCompleto;
  
}
