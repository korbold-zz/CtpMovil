import 'package:cloud_firestore/cloud_firestore.dart';

class LugaresApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  LugaresApi(this.path) {
    ref = _db.collection(path);
    print('RESULTADO--------------------:  '+ref.snapshots().toString());
  }
  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamLugarCodigo(String cod) {
    return  ref.where('CODRUTA', isEqualTo: cod).snapshots();
  }

  Stream<QuerySnapshot> streamRuta(String cod) {
    return  ref.where('email', isEqualTo: cod).snapshots();
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
