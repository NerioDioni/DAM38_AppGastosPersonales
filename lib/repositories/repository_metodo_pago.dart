import 'package:dam38_appgastospersonales/model/metodo_pago.dart';
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/repositories/db_handler.dart';
import 'package:dam38_appgastospersonales/repositories/repository_tipo_pago.dart';
import 'package:dam38_appgastospersonales/repositories/repository_usuario.dart';

import '../model/usuario.dart';

class RepositoryMetodoPago {
  final dbhandeler = databaseHandler();
  final repositoryUsuario = RepositoryUsuario();
  final repositoryTipoPago = RepositoryTipoPago();

  Future<List<MetodoPago>> listMetodosPagos() async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> metodosPagosMaps = await mydb.query('metodo_pagos');
    await mydb.close();
    return [
      for (final {
        'idmetodo_pago': idMetodoPago as int,
        'numero_cuenta': numeroCuenta as String,
        'idtipo_pago': idTipoPago as int,
        'idusuario': idUsuario as int,
      } in metodosPagosMaps)
        MetodoPago(
          idMetodoPago: idMetodoPago,
          numeroCuenta: numeroCuenta,
          tipoPago: await repositoryTipoPago.getTipoPagoById(idTipoPago),
          usuario: await repositoryUsuario.getUsuarioById(idUsuario),
        ),
    ];    
  }
  //obtener metodo de pago por id
  Future<MetodoPago> getMetodoPagoById(int id) async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> metodosPagosMaps = await mydb.query(
      'metodo_pagos',
      where: 'idmetodo_pago = ?',
      whereArgs: [id],
    );
    await mydb.close();
    if (metodosPagosMaps.isNotEmpty) {
      return MetodoPago(
        idMetodoPago: int.parse(metodosPagosMaps[0]['idmetodo_pago'].toString()),
        numeroCuenta: metodosPagosMaps[0]['numero_cuenta'].toString(),
        tipoPago: await repositoryTipoPago.getTipoPagoById(int.parse(metodosPagosMaps[0]['idtipo_pago'].toString())),
        usuario: await repositoryUsuario.getUsuarioById(int.parse(metodosPagosMaps[0]['idusuario'].toString())),
      );
    }
    return MetodoPago(
      idMetodoPago: 0,
      numeroCuenta: 'No encontrado',
      tipoPago: TipoPago(idTipoPago: 0, nombre: 'No encontrado'),
      usuario: Usuario(idusuario: 0, nombre: 'No encontrado', clave: 'No encontrado'),
    );
  }


  Future<void> printMetodosPagos() async {
    print(await listMetodosPagos());
  }




}