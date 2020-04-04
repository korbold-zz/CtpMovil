class ClientesModel {
  int codigo;
  String nombreCompleto;
  String cobrador;
  String nombreRuta;
  String fechaSig;

  ClientesModel(
      {this.nombreCompleto,
      this.cobrador,
      this.codigo,
      this.nombreRuta,
      this.fechaSig});

  ClientesModel.fromMap(Map snapshot)
      : nombreCompleto = snapshot['NOMCLI'] ?? '',
        codigo = snapshot['CODCLI'] ?? '',
        nombreRuta = snapshot['ZONA'] ?? '',
        cobrador = snapshot['CODCOB'] ?? '',
        fechaSig =  snapshot['SIGVI'] ?? '';
  toJson() {
    return {
      "NOMCLI": nombreCompleto,
      "CODCOB": cobrador,
      "CODCLI": codigo,
      "ZONA": nombreRuta,
      "ZONA": fechaSig,
    };
  }
}
