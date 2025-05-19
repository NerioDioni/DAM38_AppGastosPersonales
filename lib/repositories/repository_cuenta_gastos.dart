import 'package:dam38_appgastospersonales/model/cuentaGastos.dart';

import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart';
import 'package:dam38_appgastospersonales/repositories/db_handler.dart';

import 'package:dam38_appgastospersonales/repositories/repository_tipo_gasto.dart';
import 'package:dam38_appgastospersonales/repositories/repository_tipo_pago.dart';
import 'package:dam38_appgastospersonales/repositories/repository_usuario.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryCuentaGastos {
  final dbhandeler = databaseHandler();
  final repositoryUsuario = RepositoryUsuario();
  final repositoryTipoGasto = RepositoryTipoGasto();
  final repositoryTipoPago = RepositoryTipoPago();
  String tableCuentaGastos="cuenta_gastos";
  //var monthByYear;
  
  

  Future<List<CuentaGastos>> listCuentasGastos() async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> cuentasGastosMaps = await mydb.query(tableCuentaGastos);
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
  Future<List<CuentaGastos>> listCuentasGastosBYUser(int idUser,String anio,String month ) async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> cuentasGastosMaps;
      /*cuentasGastosMaps = await mydb.query(
          tableCuentaGastos,
          where: 'idusuario = ?',
          whereArgs: [idUser],
          );*/

      //String anio='2025' ;
      //String month='05';
      cuentasGastosMaps = await mydb.rawQuery('''
      SELECT *
      FROM $tableCuentaGastos
      WHERE idusuario=$idUser AND strftime('%Y', fecha)='$anio' AND strftime('%m', fecha)='$month'
      ORDER BY fecha DESC''');
    await mydb.close();
    print("cuentaGAstosMpas desde repositorio");
    print(cuentasGastosMaps);
    
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
  Future<Map<String, dynamic>> totalGastosMesByAnio(int idUser,String anio,String month ) async {
    var monto;
    final mydb = await dbhandeler.openDataBase();
    //final List<Map<String, dynamic>> cuentasGastosMaps;    
    /*  cuentasGastosMaps = await mydb.rawQuery('''
      SELECT *
      FROM $tableCuentaGastos
      WHERE idusuario=$idUser AND strftime('%Y', fecha)='$anio' AND strftime('%m', fecha)='$month'
      ORDER BY fecha DESC''');
    print("cuentaGAstosMpas desde repositorio");
    print(cuentasGastosMaps);*/
    
    monto= await mydb.rawQuery('''
      SELECT SUM(monto) AS total_mes
      FROM $tableCuentaGastos
      WHERE idusuario=$idUser AND strftime('%Y', fecha)='$anio' AND strftime('%m', fecha)='$month'
      ''');
    await mydb.close();
    var montoMap=monto[0];
    print(montoMap);
    return montoMap;
    
  }


  Future<CuentaGastos> getCuentaGastosById(int id) async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> cuentasGastosMaps = await mydb.query(
      tableCuentaGastos,
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
  int result = await mydb.delete(tableCuentaGastos,
        where: 'idgasto = ?',
        whereArgs: [id]);
  await mydb.close();
  return result;
  }

  Future<int> actualizarGasto(CuentaGastos gasto) async{ 
    final mydb = await dbhandeler.openDataBase();
    int result = await mydb.update(tableCuentaGastos, gasto.toMapUpdate(), where: 'idgasto = ?', whereArgs: [gasto.idgasto]);
    await mydb.close();
    return result;
  }
  Future<int> insertGasto(CuentaGastos gasto) async{
    final mydb = await dbhandeler.openDataBase();
    int result = await mydb.insert(tableCuentaGastos, gasto.toMapCreate(),conflictAlgorithm: ConflictAlgorithm.replace);
    await mydb.close();
    return result;
  }
  Future<List<Map<String,Object?>>> getListMonthByYearByUser(int idUser) async {
     final mydb = await dbhandeler.openDataBase();
     //consulta avanzada
      
      /*
      String anio=" '2025' ";
      String month=" '05' ";
      final monthByYear=await mydb.rawQuery('''
      SELECT DISTINCT strftime('%Y', fecha) AS año,strftime('%m', fecha) AS mes,COUNT(*) AS resgistros_mes,SUM(monto) AS total_mes,ROWID as id
      FROM $tableCuentaGastos
      WHERE idusuario=$idUser AND strftime('%Y', fecha)=$anio AND strftime('%m', fecha)=$month
      GROUP BY año,mes
      ORDER BY año DESC, mes DESC''');*/
      final monthByYear=await mydb.rawQuery('''
      SELECT DISTINCT strftime('%Y', fecha) AS anio,strftime('%m', fecha) AS mes,COUNT(*) AS resgistros_mes,SUM(monto) AS total_mes,ROWID as id
      FROM $tableCuentaGastos
      WHERE idusuario=$idUser 
      GROUP BY anio,mes
      ORDER BY anio DESC, mes DESC''');
      await mydb.close();
      
      return monthByYear;
    
  }


}