class LugaresModel {
  String codRuta;
  String codCobrador;
  String nombreRuta;

  LugaresModel({this.codRuta, this.codCobrador, this.nombreRuta});

  LugaresModel.fromMap(Map snapshot)
      : codRuta = snapshot['CODRUTA'] ?? '',
        nombreRuta = snapshot['NOMDIVPOL'] ?? '',
        codCobrador = snapshot['CODCOB'] ?? '';
  toJson() {
    return {
      "CODRUTA": codRuta,
      "CODCOB": codCobrador,
      "NOMDIVPOL": nombreRuta,
    };
  }
}
