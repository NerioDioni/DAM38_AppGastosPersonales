import 'package:dam38_appgastospersonales/views/gastos_view.dart';
import 'package:flutter/material.dart';

class App38GastosView extends StatelessWidget {
  App38GastosView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      //debugPaintSizeEnabled: true,
      title: 'Gastos personales',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 68, 204, 209)),),
      home:  GastosView(title: 'MAIN BOARD'),
    );
  }
}
