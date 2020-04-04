import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  UsuariosApi(this.path) {
    ref = _db.collection(path);
    print('RESULTADO--------------------:  ' + ref.snapshots().toString());
  }
  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot>  streamPorRutaUsuario(String email) {
    return ref.where('email', isEqualTo: email).snapshots();
  }

  Stream<QuerySnapshot> streamUsuarios() {
    return ref.snapshots();
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
