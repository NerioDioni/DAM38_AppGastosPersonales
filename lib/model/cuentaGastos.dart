
import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart' show Usuario;

class CuentaGastos {
   int idgasto;  
  final String descripcion;
  final DateTime fecha; // Assuming this is a date string in 'YYYY-MM-DD' format
  final double monto;
  final TipoGasto tipoGasto; // Assuming TipoGasto is a class you have defined
  final TipoPago tipoPago; // Assuming MetodoPago is a class you have defined   
  final Usuario usuario; // Assuming Usuario is a class you have defined
  
  
  CuentaGastos({
    required this.idgasto,
    required this.descripcion,
    required this.fecha,
    required this.monto,
    required this.tipoGasto,
    required this.tipoPago,
    required this.usuario,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'idgasto': idgasto,
      'descripcion': descripcion,
      'fecha': fecha,
      'monto': monto,
      'tipoGasto': tipoGasto.toMap(), // Assuming TipoGasto has a toMap() method
      'metodoPago': tipoPago.toMap(), // Assuming MetodoPago has a toMap() method
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
    return 'CuentaGastos{idgasto: $idgasto,descripcion: $descripcion, fecha: $fecha,monto: $monto, tipoGasto: $tipoGasto, tipoPago: $tipoPago, usuario: $usuario}';
  }

  String getIdGasto() => idgasto.toString();
  String getDescripcion() => descripcion;
  //get getFecha => fecha;  
  String  getMonto() => monto.toString();
  TipoGasto getTipoGasto() => tipoGasto;
  TipoPago getTipoPago() => tipoPago;
  Usuario getUsuario() => usuario;
  set setIdGasto(int idGasto) => idgasto = idGasto;
  set setDescripcion(String descripcion) => descripcion = descripcion;
  set setFecha(DateTime fecha) => fecha = fecha;
  set setMonto(double monto) => monto = monto;
  set setTipoGasto(TipoGasto tipoGasto) => tipoGasto = tipoGasto;
  set setTipoPago(TipoPago tipoPago) => tipoPago = tipoPago;   
  set setUsuario(Usuario usuario) => usuario = usuario; 
    
}

