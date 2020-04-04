import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/core/Models/lugares_model.dart';
import 'package:ctp1/core/Services/lugares_api.dart';

import 'package:flutter/widgets.dart';

class LugaresProv with ChangeNotifier {
  // ClientesApi _api = locator<ClientesApi>();
  LugaresApi _api = LugaresApi('Lugares');
  String lugar;
  List<LugaresModel> lugares;

  Future<List<LugaresModel>> fetchProducts() async {
    var result = await _api.getDataCollection();
    lugares = result.documents
        .map((doc) => LugaresModel.fromMap(
              doc.data,
            ))
        .toList();

    return lugares;
  }

  setLugar(String lugar) => this.lugar = lugar;

  Stream<QuerySnapshot> lugarCodigo() {
    return _api.streamLugarCodigo(this.lugar);
  }

  Stream<QuerySnapshot> getRuta(String cod) {
    return _api.streamRuta(cod);
  }

  Future<LugaresModel> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    notifyListeners();
    return LugaresModel.fromMap(
      doc.data,
    );
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    notifyListeners();
    return;
  }

  Future updateProduct(LugaresModel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(LugaresModel data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
