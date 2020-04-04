import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:ctp1/core/Services/clientes_api.dart';
import 'package:flutter/widgets.dart';




class ClientesProv with ChangeNotifier {
  // ClientesApi _api = locator<ClientesApi>();
  ClientesApi _api = ClientesApi('clientesCtp1');

  List<ClientesModel> clientes;
  String lugar;
  String _nombreLugar;

  Future<List<ClientesModel>> fetchProducts() async {
    var result = await _api.getDataCollection();
    clientes = result.documents
        .map((doc) => ClientesModel.fromMap(doc.data,))
        .toList();
        
    return clientes;
  }

  setLugar(String lugar) => this.lugar = lugar;
  setNombreLugar(String nombrelugar) => this._nombreLugar = nombrelugar;
  getNombreLugar()=>this._nombreLugar;

  Stream<QuerySnapshot> lugarCodigo() {
    return _api.streamLugarCodigo(this.lugar);
  }
  Stream<QuerySnapshot> getRuta() {
    
    return _api.streamRuta();
  }

  Future<ClientesModel> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    notifyListeners();
    return  ClientesModel.fromMap(doc.data,) ;
  }


  Future removeProduct(String id) async{
     await _api.removeDocument(id) ;
     notifyListeners();
     return ;
  }
  Future updateProduct(ClientesModel data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(ClientesModel data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }


}