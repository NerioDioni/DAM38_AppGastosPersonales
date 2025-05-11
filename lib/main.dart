import 'package:dam38_appgastospersonales/views/app38_gastos_view.dart';
//import 'package:dam38_appgastospersonales/views_test/main_app38.dart';

import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    routes: {
      '/': (context) => App38GastosView()},
    initialRoute: '/', 
  ));
}
// '/': (context) => App38GastosView()},
