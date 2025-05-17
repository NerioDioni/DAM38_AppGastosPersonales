class TipoPago {
  final int idTipoPago;
  final String nombre;

  TipoPago({
    required this.idTipoPago,
    required this.nombre,
  });

  Map<String, dynamic> toMap() {
    return {
      'idtipo_pago': idTipoPago,
      'nombre': nombre,
    };
  }
  @override
  String toString() {
    return 'TipoPago{idTipoPago: $idTipoPago, nombre: $nombre}';
  }
  String getIdTipoPago() => idTipoPago.toString();
  String getNombre()=> nombre;
}