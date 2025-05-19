
import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart' show Usuario;

class CuentaGastos {
  int idgasto;  
  String descripcion;
  DateTime fecha; // Assuming this is a date string in 'YYYY-MM-DD' format
  double monto;
  TipoGasto tipoGasto; // Assuming TipoGasto is a class you have defined
  TipoPago tipoPago; // Assuming MetodoPago is a class you have defined   
  Usuario usuario; // Assuming Usuario is a class you have defined
  
  
  /*CuentaGastos.empty({
    this.idgasto= 0,
    this.descripcion= 'No encontrado',
    this.fecha=,
    this.monto= 0.0,
    this.tipoGasto= TipoGasto(idTipoGasto: 0, nombre: 'No encontrado', Codigo: 'No encontrado'),
    this.tipoPago=  TipoPago(idTipoPago: 0, nombre: 'No encontrado'),      
    this.usuario= Usuario(idusuario: 0, nombre: 'No encontrado', clave: 'No encontrado'),

  });*/ 
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
  //mapa para actualizar  registro
  Map<String, dynamic> toMapUpdate() {
    return {
      
      'descripcion': descripcion,
      'fecha': dateString(),
      'monto': monto,
      'idtipo_gasto': tipoGasto.idTipoGasto, 
      'idtipo_pago': tipoPago.idTipoPago,
       
      
    };
  }
  //mapa para insertar nuevo resgistro de gasto
  Map<String, dynamic> toMapCreate() {
    return {
      'descripcion': descripcion,
      'fecha': dateString(),
      'monto': monto,
      'idtipo_gasto': tipoGasto.idTipoGasto, 
      'idtipo_pago': tipoPago.idTipoPago, 
      'idusuario': usuario.idusuario,
      
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
    return 'CuentaGastos{idgasto: $idgasto, \ndescripcion: $descripcion, \nfecha: $fecha, \nmonto: $monto, \ntipoGasto: $tipoGasto, \ntipoPago: $tipoPago, \nusuario: $usuario}';
  }

  String getIdGasto() => idgasto.toString();
  String getDescripcion() => descripcion;
  //get getFecha => fecha;  
  String  getMonto() => monto.toStringAsFixed(2);
  TipoGasto getTipoGasto() => tipoGasto;
  TipoPago getTipoPago() => tipoPago;
  Usuario getUsuario() => usuario;
  void setIdGasto(int newIdGasto) => idgasto = newIdGasto;
  void setDescripcion(String newDescripcion) => descripcion = newDescripcion;
  void setFecha(DateTime newFecha) => fecha = newFecha;
  void setMonto(double newMonto) => monto = newMonto;
  void setTipoGasto(TipoGasto newTipoGasto) => tipoGasto = newTipoGasto;
  void setTipoPago(TipoPago newTipoPago) => tipoPago = newTipoPago;   
  void setUsuario(Usuario newUsuario) => usuario = newUsuario; 
    
}

