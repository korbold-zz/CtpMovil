import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctp1/core/Models/usuarios_model.dart';
import 'package:ctp1/core/Services/usuarios_api.dart';

import 'package:flutter/widgets.dart';

class UsuariosProv with ChangeNotifier {
  // ClientesApi _api = locator<ClientesApi>();
  UsuariosApi _api = UsuariosApi('Usuarios');

  List<UsuariosModel> lugares;

  Future<List<UsuariosModel>> fetchProducts() async {
    var result = await _api.getDataCollection();
    lugares = result.documents
        .map((doc) => UsuariosModel.fromMap(
              doc.data,
            ))
        .toList();

    return lugares;
  }

  Stream<QuerySnapshot> fecthRutaUsuario(String email) {
    return _api.streamPorRutaUsuario(email);
  }

  Future<UsuariosModel> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    notifyListeners();
    return UsuariosModel.fromMap(
      doc.data,
    );
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    notifyListeners();
    return;
  }

  Future updateProduct(UsuariosModel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(UsuariosModel data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
