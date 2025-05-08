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
        CREATE TABLE IF NOT EXISTS metodo_pagos(
          idmetodo_pago INTEGER PRIMARY KEY AUTOINCREMENT,
          numero_cuenta TEXT,
          idusuario INTEGER,
          idtipo_pago INTEGER,
          FOREIGN KEY (idusuario) 
          REFERENCES usuarios(idusuario) on update cascade on delete cascade, 
          FOREIGN KEY (idtipo_pago) 
          REFERENCES tipo_pagos(idtipo_pago) on update cascade on delete cascade                   
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
          idmetodo_pago INTEGER,
          FOREIGN KEY (idusuario) 
          REFERENCES usuarios(idusuario) on update cascade on delete cascade,          
          FOREIGN KEY (idtipo_gasto) 
          REFERENCES tipo_gastos(idtipo_gasto) on update cascade on delete cascade,   
          FOREIGN KEY (idmetodo_pago) 
          REFERENCES metodo_pagos(idmetodo_pago) on update cascade on delete cascade        
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
//esto es para cargar los metodos de pago
      await db.execute('''
        INSERT INTO metodo_pagos(numero_cuenta, idtipo_pago, idusuario) VALUES
        ('123456789', 1, 1),
        ('987654321', 2, 2),
        ('456789123', 3, 3),
        ('321654987', 4, 1),
        ('654321789', 5, 2);
        
      ''');
//esto es para cargar los gastos
      await db.execute('''
        INSERT INTO cuenta_gastos(fecha, monto, descripcion, idusuario, idtipo_gasto, idmetodo_pago) VALUES
        (CURRENT_DATE, 100.0, 'Compra de comida', 1, 1, 1),
        (CURRENT_DATE, 50.0, 'Pasaje de bus', 2, 2, 2),
        (CURRENT_DATE, 200.0, 'Pago de alquiler', 3, 3, 3),
        (CURRENT_DATE, 150.0, 'Compra de ropa', 1, 4, 4),
        (CURRENT_DATE, 75.0, 'Pago de servicios', 2, 5, 5),
        (CURRENT_DATE, 300.0, 'Compra de electronicos', 3, 6, 6),
        (CURRENT_DATE, 500.0, 'Pago de prestamo', 1, 7, 7), 
        (CURRENT_DATE, 250.0, 'Ahorro mensual', 2, 8, 8),
        (CURRENT_DATE, 1000.0, 'Compra de muebles', 3, 1, 1),
        (CURRENT_DATE, 600.0, 'Pago de colegio', 1, 2, 2);
        
      ''');




  }


}