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

  List<dynamic> _listas;

  List<dynamic> get getLista  => _listas;
  setLista(){

  }

  String get idCliente => id;

  setIdCliente(String id)=> this.id= id;


  String get getNombreCliente { 
    
    return nombreCliente;}

   setNombreCliente(String nombreCliente) 
     { this.nombreCliente = nombreCliente;
     notifyListeners();
     }

  String get getCelular => celular;

   setCelular(String celular) => this.celular = celular;

  String get getTelefono => telefono;

   setTelefono(String telefono) => this.telefono = telefono;

  String get getProducto => producto;

   setProducto(String producto) => this.producto = producto;

  String get getFechaSig => fechaSig;

   setFechaSig(String fechaSig) => this.fechaSig = fechaSig;

  dynamic get getValor => valor;

   setValor(dynamic valor) => this.valor = valor;

  String get getDireccion => direccion;

   setDireccion(String direccion) => this.direccion = direccion;
}
