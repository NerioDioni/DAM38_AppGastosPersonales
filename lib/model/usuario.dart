class Usuario {
  final String id;
  final String nombre;


  Usuario({
    required this.id,
    required this.nombre
    });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
            

  
 }