import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/repositories/db_handler.dart';

class RepositoryTipoGasto {
  final dbhandeler = databaseHandler();

  Future  <List<TipoGasto>> listTipoGastos() async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> tipoGastosMaps = await mydb.query('tipo_gastos');
    await mydb.close();
    return [
      for (final {
        'idtipo_gasto': idTipoGasto as int,
        'nombre': nombre as String,
        'codigo': codigo as String,
      } in tipoGastosMaps)
        TipoGasto(
          idTipoGasto: idTipoGasto,
          nombre: nombre,
          Codigo: codigo,
        ),
    ];
  }

  Future <void> printTipoGastos() async {
    print(await listTipoGastos());
  }
  //agregar metodo getbyid
  Future<TipoGasto> getTipoGastoById(int id) async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> tipoGastosMaps = await mydb.query(
      'tipo_gastos',
      where: 'idtipo_gasto = ?',
      whereArgs: [id],
    );
    await mydb.close();
    if (tipoGastosMaps.isNotEmpty) {
      return TipoGasto(
        idTipoGasto:int.parse(tipoGastosMaps[0]['idtipo_gasto'].toString()),
        nombre: tipoGastosMaps[0]['nombre'].toString(),
        Codigo: tipoGastosMaps[0]['codigo'].toString(),
      );
    }
    return TipoGasto(
      idTipoGasto: 0,
      nombre: 'No encontrado',
      Codigo: 'No encontrado',
    );
  }
  

}