class ClientesModel {
  
  int codigo;
  String nombreCompleto;
  String cobrador;


  ClientesModel({this.nombreCompleto, this.cobrador, this.codigo});

  ClientesModel.fromMap(Map snapshot)
      : nombreCompleto = snapshot['NOMCLI'] ?? '',
       codigo = snapshot['CODCLI'] ?? '',
        cobrador = snapshot['CODCOB'] ?? '';
  toJson() {
    return {
      "NOMCLI": nombreCompleto,
      "CODCOB": cobrador,
      "CODCLI": codigo,
    };
  }
}
