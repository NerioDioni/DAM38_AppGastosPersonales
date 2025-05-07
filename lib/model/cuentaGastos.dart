import 'package:dam38_appgastospersonales/model/metodo_pago.dart' show MetodoPago;
import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart' show Usuario;

class CuentaGastos {
  final int idgastopersonal;  
  final String descripcion;
  final String fecha; // Assuming this is a date string in 'YYYY-MM-DD' format
  final double monto;
  final TipoGasto tipoGasto; // Assuming TipoGasto is a class you have defined
  final MetodoPago metodoPago; // Assuming MetodoPago is a class you have defined   
  final Usuario usuario; // Assuming Usuario is a class you have defined
  
  
  CuentaGastos({
    required this.idgastopersonal,
    required this.descripcion,
    required this.fecha,
    required this.monto,
    required this.tipoGasto,
    required this.metodoPago,
    required this.usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idgastopersonal': idgastopersonal,
      'descripcion': descripcion,
      'fecha': fecha,
      'monto': monto,
      'tipoGasto': tipoGasto.toMap(), // Assuming TipoGasto has a toMap() method
      'metodoPago': metodoPago.toMap(), // Assuming MetodoPago has a toMap() method
      'usuario': usuario.toMap(), // Assuming Usuario has a toMap() method    
    };
  }
}

