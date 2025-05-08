
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart';

class MetodoPago {
  final int idMetodoPago;
  final String numeroCuenta;
  final TipoPago tipoPago;
  final Usuario usuario; // Assuming TipoGasto is a class you have defined

  MetodoPago({
    required this.idMetodoPago,
    required this.numeroCuenta,
    required this.tipoPago,
    required this.usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idmetodo_pago': idMetodoPago,
      'numero_Cuenta': numeroCuenta,
      'tipoGasto': tipoPago.toMap(),// Assuming TipoGasto has a toMap() method
      'usuario': usuario.toMap(), // Assuming Usuario has a toMap() method    
    };
  }
  @override
  String toString() {
    return 'MetodoPago{idMetodoPago: $idMetodoPago, numeroCuenta: $numeroCuenta, tipoPago: $tipoPago, usuario: $usuario}';
  }
  

}