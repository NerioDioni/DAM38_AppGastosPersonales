import 'package:dam38_appgastospersonales/model/cuentaGastos.dart';

import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart';
import 'package:dam38_appgastospersonales/repositories/db_handler.dart';

import 'package:dam38_appgastospersonales/repositories/repository_tipo_gasto.dart';
import 'package:dam38_appgastospersonales/repositories/repository_tipo_pago.dart';
import 'package:dam38_appgastospersonales/repositories/repository_usuario.dart';

class RepositoryCuentaGastos {
  final dbhandeler = databaseHandler();
  final repositoryUsuario = RepositoryUsuario();
  final repositoryTipoGasto = RepositoryTipoGasto();
  final repositoryTipoPago = RepositoryTipoPago();
  
  

  Future<List<CuentaGastos>> listCuentasGastos() async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> cuentasGastosMaps = await mydb.query('cuenta_gastos');
    await mydb.close();
    return [
      for (final {
        'idgasto': idGasto as int,
        'descripcion': descripcion as String,
        'fecha': fecha as String,
        'monto': monto as double,
        'idtipo_gasto': idTipoGasto as int,
        'idtipo_pago': idTipoPago as int,
        'idusuario': idUsuario as int,
      } in cuentasGastosMaps)
        CuentaGastos(
          idgasto: idGasto,
          descripcion: descripcion,
          fecha: DateTime.parse(fecha),
          monto: monto,
          tipoGasto: await repositoryTipoGasto.getTipoGastoById(idTipoGasto),
          tipoPago: await repositoryTipoPago.getTipoPagoById(idTipoPago),
          usuario: await repositoryUsuario.getUsuarioById(idUsuario),
        ),
    ];
  }

  Future<CuentaGastos> getCuentaGastosById(int id) async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> cuentasGastosMaps = await mydb.query(
      'cuenta_gastos',
      where: 'idgasto = ?',
      whereArgs: [id],
    );
    await mydb.close();
    if (cuentasGastosMaps.isNotEmpty) {
      return CuentaGastos(
        idgasto: int.parse(cuentasGastosMaps[0]['idgasto'].toString()),
        descripcion: cuentasGastosMaps[0]['descripcion'].toString(),
        fecha: DateTime.parse(cuentasGastosMaps[0]['fecha'].toString()),
        monto: double.parse(cuentasGastosMaps[0]['monto'].toString()),
        tipoGasto: await repositoryTipoGasto.getTipoGastoById(int.parse(cuentasGastosMaps[0]['idtipo_gasto'].toString())),
        tipoPago: await repositoryTipoPago.getTipoPagoById(int.parse(cuentasGastosMaps[0]['idtipo_pago'].toString())),
        usuario: await repositoryUsuario.getUsuarioById(int.parse(cuentasGastosMaps[0]['idusuario'].toString())),
      );
    }
    return CuentaGastos(
      idgasto: 0,
      descripcion: 'No encontrado',
      fecha: DateTime.now(),
      monto: 0.0,
      tipoGasto: TipoGasto(idTipoGasto: 0, nombre: 'No encontrado', Codigo: 'No encontrado'),
      tipoPago:  TipoPago(idTipoPago: 0, nombre: 'No encontrado'),      
      usuario: Usuario(idusuario: 0, nombre: 'No encontrado', clave: 'No encontrado'),
    );
  }
  
  Future<void> printCuentasGastos() async {
    print(await listCuentasGastos());
  }

Future<int> deleteById(int id) async {
  final mydb = await dbhandeler.openDataBase();
  int result = await mydb.delete('cuenta_gastos',
        where: 'idgasto = ?',
        whereArgs: [id]);
  await mydb.close();
  return result;
  }




}