import 'package:cloud_firestore/cloud_firestore.dart';

class ClientesApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  ClientesApi(this.path) {
    ref = _db.collection(path);
    print('RESULTADO--------------------' + ref.toString());
  }
  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamLugarCodigo(String cod) {
    return ref.where('CODRUTA', isEqualTo: cod).snapshots();
  }

  Stream<QuerySnapshot> streamRuta() {
    return ref.where('CODCOB', isEqualTo: 'C6').snapshots();
  }

  Stream<QuerySnapshot> getPagosDocumentById(String id) {
    return ref.document(id).collection('PAGOS').orderBy('FECHA_PAGO',descending: true).snapshots();
  }

  Future<void> removeDocument(String id, String id2) {
    return ref.document(id).collection('PAGOS').document(id2).delete();
  }

  Future<void> addDocument(Map data, String id) {
    return ref.document(id).collection('PAGOS').document().setData(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData({
      'SALDOC':data['SALDOC']
    });
  }

  Future<void> updateDatosCliente(Map data, String id) {
    return ref.document(id).updateData({
      'NOMCLI':data['NOMCLI'],
      'CELCLI':data['CELCLI'],
      'TELCLI':data['TELCLI'],
    });
  }

  Future<void> updateFecha(Map data, String id) {
    return ref.document(id).updateData({
      'SIGVI':data['SIGVI']
    });
  }
}
