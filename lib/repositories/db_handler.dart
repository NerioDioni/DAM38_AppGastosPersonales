import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';
class databaseHandler{
  Future <Database> openDataBase() async{
        final databasepath = await getDatabasesPath();
        final path = join(databasepath, 'mybase.db');
        print(path);
        return openDatabase(
          path,
          version: 1,
          onCreate: _oncreate,
          );
}
  //esto es para crear la base de datos y las tablas
  void _oncreate(Database db, int version) async {
      await db.execute('''
        CREATE TABLE tipo_gastos(
          idtipo_gasto INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          codigo TEXT           
        );              
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS tipo_pagos(
          idtipo_pago INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT
        );
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS usuarios(
          idusuario INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          clave TEXT           
        );
      ''');     
      await db.execute(''' PRAGMA foreign_keys = ON; ''');      
      await db.execute('''
        CREATE TABLE IF NOT EXISTS cuenta_gastos(
          idgasto INTEGER PRIMARY KEY AUTOINCREMENT,
          fecha DATE DEFAULT CURRENT_DATE,
          monto REAL,
          descripcion TEXT,
          idusuario INTEGER,
          idtipo_gasto INTEGER,
          idtipo_pago INTEGER,
          FOREIGN KEY (idusuario) 
          REFERENCES usuarios(idusuario) on update cascade on delete cascade,          
          FOREIGN KEY (idtipo_gasto) 
          REFERENCES tipo_gastos(idtipo_gasto) on update cascade on delete cascade,   
          FOREIGN KEY (idtipo_pago) 
          REFERENCES tipo_pagos(idtipo_pago) on update cascade on delete cascade        
        );
      ''');
  //esto es para cargar tipo gasto 
      await db.execute('''
        INSERT INTO tipo_gastos(nombre, codigo) VALUES
        ('Alimentacion', '001'),
        ('Transporte', '002'),
        ('Vivienda', '003'),
        ('Salud', '004'),
        ('Educacion', '005'),
        ('Entretenimiento', '006'),
        ('Prestamos', '007'),
        ('ahorro', '008');
        
      ''');
 //esto es para cargar los tipos de pago
      await db.execute('''
        INSERT INTO tipo_pagos(nombre) VALUES
        ('Efectivo'),
        ('Tarjeta de credito'),
        ('Tarjeta de debito'),
        ('Transferencia'),
        ('Cheque'),
        ('Criptomonedas');
        
      ''');
//esto es para cargar los usuarios
      await db.execute('''
        INSERT INTO usuarios(nombre, clave) VALUES
        ('admin', 'admin'),
        ('user1', 'user1'),
        ('user2', 'user2');
      
      ''');
//esto es para cargar cuenta gastos
      await db.execute('''
        INSERT INTO cuenta_gastos(fecha, monto, descripcion, idusuario, idtipo_gasto, idtipo_pago) VALUES
        ('2023-10-01', 100.0, 'Compra de comida', 1, 1, 1),
        ('2023-10-02', 50.0, 'Pasaje de bus', 1, 2, 2),
        ('2023-10-03', 200.0, 'Alquiler de casa', 1, 3, 3),
        ('2023-10-04', 150.0, 'Medicamentos', 1, 4, 4),
        ('2023-10-05', 300.0, 'Libros', 2, 5, 5),
        ('2023-10-06', 80.0, 'Cine', 1, 6, 5),      
        ('2023-10-09', 120.0, 'Compra de ropa', 1, 1, 1),
        ('2023-10-10', 60.0, 'Gasolina', 1, 2, 2),
        ('2023-10-11', 250.0, 'Alquiler de oficina', 2, 3, 3),
        ('2023-10-12', 90.0, 'Consulta medica', 1, 4, 4),
        ('2023-10-13', 400.0, 'Cursos en linea', 1, 5, 5),
        ('2023-10-14', 70.0, 'Concierto', 2, 6, 3),
        ('2023-10-15', 600.0, 'Pago de tarjeta de credito', 1, 6, 4);
        
      ''');    

  }


}