
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart';

class MetodoPago {
  final String idmetodoPago;
  final String numeroCuenta;
  final TipoPago tipoPago;
  final Usuario usuario; // Assuming TipoGasto is a class you have defined

  MetodoPago({
    required this.idmetodoPago,
    required this.numeroCuenta,
    required this.tipoPago,
    required this.usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idmetodoPago': idmetodoPago,
      'NumeroCuenta': numeroCuenta,
      'tipoGasto': tipoPago.toMap(),// Assuming TipoGasto has a toMap() method
      'usuario': usuario.toMap(), // Assuming Usuario has a toMap() method    
    };
  }

}