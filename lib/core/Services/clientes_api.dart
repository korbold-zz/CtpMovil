import 'package:cloud_firestore/cloud_firestore.dart';

class ClientesApi {
  final Firestore _db = Firestore.instance;
  final String path;
  var ref;

  ClientesApi(this.path) {
    ref = _db.collection(path);
    print('RESULTADO--------------------'+ref.toString());
  }
  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return  ref.where('CODCOB', isEqualTo: 'C6').snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
