import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/repositories/db_handler.dart';

class RepositoryTipoPago {
  final dbhandeler = databaseHandler();
  
  
  Future<List<TipoPago>> listTipoPagos() async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> tipoPagosMaps = await mydb.query('tipo_pagos');  
     await mydb.close();
    return [
      for (final {
          'idtipo_pago': idTipoPago as int,
          'nombre': nombre as String,
        }in tipoPagosMaps)
        TipoPago(
          idTipoPago: idTipoPago, 
          nombre: nombre,
        ),
    ]; 
  }

  Future<void> printTipoPagos() async {
    print(await listTipoPagos());
  }



  //agregar metodo getbyid
  Future<TipoPago> getTipoPagoById(int id) async {
    final mydb = await dbhandeler.openDataBase();
    final List<Map<String, dynamic>> tipoPagosMaps = await mydb.query(
      'tipo_pagos',
      where: 'idtipo_pago = ?',
      whereArgs: [id],
    );
    await mydb.close();
    if (tipoPagosMaps.isNotEmpty) {
      //final id= int.parse(tipoPagosMaps[0]['idtipo_pago'].toString());
      //final name= tipoPagosMaps[0]['nombre'].toString();
      return TipoPago(
        idTipoPago: int.parse(tipoPagosMaps[0]['idtipo_pago'].toString()),
        nombre: tipoPagosMaps[0]['nombre'].toString(),
      );
    }
    return TipoPago(
      idTipoPago: 0,
      nombre: 'No encontrado',
    );
  }

}