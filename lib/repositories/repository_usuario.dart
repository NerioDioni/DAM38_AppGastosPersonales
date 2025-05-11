import 'package:dam38_appgastospersonales/model/usuario.dart';
import 'package:dam38_appgastospersonales/repositories/db_handler.dart';

class RepositoryUsuario {
  final dbhandeler = databaseHandler();
  List<Usuario> Usuarios = [];

  Future<List<Usuario>> listUsuarios() async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> usuariosMaps = await mydb.query('usuarios');
    await mydb.close();
    return [
      for (final {
        'idusuario': idusuario as int,
        'nombre': nombre as String,
        'clave': clave as String,
      } in usuariosMaps)
        Usuario(
          idusuario: idusuario,
          nombre: nombre,
          clave: clave,
        ),
    ];
  }

  Future<void> printUsuarios() async {
    print( await listUsuarios());
    
  }
Future<void> setListUsuarios() async{
  final mydb = await dbhandeler.openDataBase();
  final List<Map<String, dynamic>> usuariosMaps = await mydb.query('usuarios');
  await mydb.close();
  Usuarios = [
      for (final {
        'idusuario': idusuario as int,
        'nombre': nombre as String,
        'clave': clave as String,
      } in usuariosMaps)
        Usuario(
          idusuario: idusuario,
          nombre: nombre,
          clave: clave,
        ),
  ];
  print(Usuarios);
    
}

//agregar metodo getbyid
  Future<Usuario> getUsuarioById(int id) async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> usuariosMaps = await mydb.query(
      'usuarios',
      where: 'idusuario = ?',
      whereArgs: [id],
    );
    await mydb.close();
    if (usuariosMaps.isNotEmpty) {
      return Usuario(
        idusuario: int.parse(usuariosMaps[0]['idusuario'].toString()),
        nombre: usuariosMaps[0]['nombre'].toString(),
        clave: usuariosMaps[0]['clave'].toString(),
      );
    }
    return Usuario(
      idusuario: 0,
      nombre: 'No encontrado',
      clave: 'No encontrado',
    );
  }

}