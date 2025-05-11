class TipoGasto {
final int idTipoGasto;
  final String nombre;
  final String Codigo;
  

  TipoGasto({
    required this.idTipoGasto,
    required this.nombre,
    required this.Codigo
  });
  
  Map<String, dynamic> toMap() {
    return {
      'idtipo_gasto': idTipoGasto,
      'nombre': nombre,
      'Codigo': Codigo
    };
  }
  @override
  String toString() {
    return 'TipoGasto{idTipoGasto: $idTipoGasto, nombre: $nombre, Codigo: $Codigo}';
  }
  String getIdTipoGasto() => Codigo;
  


}