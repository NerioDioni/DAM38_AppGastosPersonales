import 'package:dam38_appgastospersonales/model/metodo_pago.dart' show MetodoPago;
import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart' show Usuario;

class CuentaGastos {
  final int idgasto;  
  final String descripcion;
  final DateTime fecha; // Assuming this is a date string in 'YYYY-MM-DD' format
  final double monto;
  final TipoGasto tipoGasto; // Assuming TipoGasto is a class you have defined
  final MetodoPago metodoPago; // Assuming MetodoPago is a class you have defined   
  final Usuario usuario; // Assuming Usuario is a class you have defined
  
  
  CuentaGastos({
    required this.idgasto,
    required this.descripcion,
    required this.fecha,
    required this.monto,
    required this.tipoGasto,
    required this.metodoPago,
    required this.usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idgasto': idgasto,
      'descripcion': descripcion,
      'fecha': fecha,
      'monto': monto,
      'tipoGasto': tipoGasto.toMap(), // Assuming TipoGasto has a toMap() method
      'metodoPago': metodoPago.toMap(), // Assuming MetodoPago has a toMap() method
      'usuario': usuario.toMap(), // Assuming Usuario has a toMap() method    
    };
  }

  String dateString() {
    //se devolvera el formato de fecha en string adecuado para la base de datos
    //solo se enviara la fecha sin la hora, por lo que se usara el split para obtener solo la fecha
    // tiene el formato YYYY-MM-DD
    final String newDate = fecha.toString().split(' ')[0];
    return newDate;
  }
  @override
  String toString() {
    return 'CuentaGastos{idgasto: $idgasto, descripcion: $descripcion, fecha: $fecha, monto: $monto, tipoGasto: $tipoGasto, metodoPago: $metodoPago, usuario: $usuario}';
  }
  
}

