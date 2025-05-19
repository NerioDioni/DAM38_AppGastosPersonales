//import 'dart:ffi';

class TipoGasto {
 int idTipoGasto;
 String nombre;
 String Codigo;
  

  TipoGasto({
    required this.idTipoGasto,
    required this.nombre,
    required this.Codigo
  });
  
  Map<String, dynamic>? toMap() {
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
  String getCodigoTipoGasto() => Codigo;
  String getIdTipoGasto()=> idTipoGasto.toString();
  String getNombre()=> nombre;
  


}