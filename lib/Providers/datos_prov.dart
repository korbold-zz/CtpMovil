import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/core/Models/clientes_model.dart';
import 'package:ctp1/core/Models/pagos_model.dart';
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
        .map((doc) => ClientesModel.fromMap(doc.data, doc.documentID))
        .toList();

    return clientes;
  }

  setLugar(String lugar) => this.lugar = lugar;
  setNombreLugar(String nombrelugar) => this._nombreLugar = nombrelugar;
  getNombreLugar() => this._nombreLugar;

  Stream<QuerySnapshot> lugarCodigo() {
    return _api.streamLugarCodigo(this.lugar);
  }

  Stream<QuerySnapshot> getRuta() {
    return _api.streamRuta();
  }

  Stream<QuerySnapshot> getPagosById(String id) {
    return _api.getPagosDocumentById(id);
  }

  Future addPago(PagosModel data, String id) async {
    var result = await _api.addDocument(data.toJson(), id);

    return;
  }


  Future updatePago(ClientesModel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

Future updateFecha(ClientesModel data, String id) async {
    await _api.updateFecha(data.toJson(), id);
    return;
  }
  Future removePago(String id, String id2) async {
    await _api.removeDocument(id, id2);
    notifyListeners();
    return;
  }

  Future updateProduct(ClientesModel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future updateDatosCliente(ClientesModel data, String id) async {
    await _api.updateDatosCliente(data.toJson(), id);
    return;
  }
  
}
