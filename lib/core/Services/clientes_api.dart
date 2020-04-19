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
    return ref.document(id).collection('PAGOS').snapshots();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<void> addDocument(Map data, String id) {
    return ref.document(id).collection('PAGOS').document().setData(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
