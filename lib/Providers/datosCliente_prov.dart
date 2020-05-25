import 'package:flutter/material.dart';

class DatosClienteProv with ChangeNotifier {
  String nombreCliente;
  String celular;
  String telefono;
  String producto;
  String fechaSig;
  dynamic valor;
  String direccion;
  String id;
  int codigoCliente;
  List<dynamic> _listas;

  int get codCliente => codigoCliente;

  setCodCliente(int codigo) => this.codigoCliente = codigo;

  List<dynamic> get getLista => _listas;
  setLista() {}

  String get idCliente => id;

  setIdCliente(String id) => this.id = id;

  String get getNombreCliente {
    return nombreCliente;
  }

  setNombreCliente(String nombreCliente) {
    this.nombreCliente = nombreCliente;
    notifyListeners();
  }

  String get getCelular => celular;

  setCelular(String celular) {
    this.celular = celular;
    notifyListeners();
  }

  String get getTelefono => telefono;

  setTelefono(String telefono) {
    this.telefono = telefono;
    notifyListeners();
  }

  String get getProducto => producto;

  setProducto(String producto) => this.producto = producto;

  String get getFechaSig {
    return fechaSig;
  }

  setFechaSig(String fechaSig) {
    notifyListeners();
    this.fechaSig = fechaSig;
  }

  dynamic get getValor {
    notifyListeners();
    return valor;
  }

  setValor(dynamic valor) {
    notifyListeners();
    return this.valor = valor;
  }

  String get getDireccion => direccion;

  setDireccion(String direccion) => this.direccion = direccion;
}
