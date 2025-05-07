class TipoPago {
  final int idtipoPago;
  final String nombretipoPago;

  TipoPago({
    required this.idtipoPago,
    required this.nombretipoPago,
  });

  Map<String, dynamic> toMap() {
    return {
      'idtipoPago': idtipoPago,
      'nombretipoPago': nombretipoPago,
    };
  }

}