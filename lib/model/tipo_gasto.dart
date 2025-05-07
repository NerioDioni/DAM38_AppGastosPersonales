class TipoGasto {
final int idTipoGasto;
  final String nombreTipoGasto;
  final String CodigoTipoGasto;
  

  TipoGasto({
    required this.idTipoGasto,
    required this.nombreTipoGasto,
    required this.CodigoTipoGasto
  });
  
  Map<String, dynamic> toMap() {
    return {
      'idTipoGasto': idTipoGasto,
      'nombreTipoGasto': nombreTipoGasto,
      'CodigoTipoGasto': CodigoTipoGasto
    };
  }
  
  


}