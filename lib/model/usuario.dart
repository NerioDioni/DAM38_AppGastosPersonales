class Usuario {
  int idusuario;
  final String nombre;
  final String clave;

  Usuario({
    required this.idusuario ,
    required this.nombre,
    required this.clave,
    });
  get getIdusuario => idusuario;
  get getNombre => nombre;
  get getClave => clave;
  set setIdusuario(int id) => idusuario = id;
  set setNombre(String nombre) => nombre = nombre;
  set setClave(String clave) => clave = clave;
  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idusuario,
      'nombre': nombre,
      'clave': clave,
    };
  }
  @override
  String toString() {
    return toMap().toString();
    //return 'Usuario{idusuario: $idusuario, nombre: $nombre, clave: $clave}';
  }          

  
 }