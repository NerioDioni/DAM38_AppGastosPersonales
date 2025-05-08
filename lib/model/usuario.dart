class Usuario {
  final int idusuario;
  final String nombre;
  final String clave;

  Usuario({
    required this.idusuario ,
    required this.nombre,
    required this.clave,
    });

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idusuario,
      'nombre': nombre,
      'clave': clave,
    };
  }
  @override
  String toString() {
    return 'Usuario{idusuario: $idusuario, nombre: $nombre, clave: $clave}';
  }          

  
 }