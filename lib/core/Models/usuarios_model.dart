class UsuariosModel {
  String codCobrador;
  String email;

  UsuariosModel({this.codCobrador, this.email});

  UsuariosModel.fromMap(Map snapshot)
      : email = snapshot['email'] ?? '',
        codCobrador = snapshot['codcob'] ?? '';
  toJson() {
    return {
      "codcob": codCobrador,
      "email": email,
    };
  }
}
