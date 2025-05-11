

import 'package:dam38_appgastospersonales/views/app38_gastos_view.dart';
import 'package:flutter/material.dart';


class ViewLogin extends StatelessWidget {
  

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => App38GastosView(),
                  ),
                );},
          child: const Text('VOLVER A VIEW REGISTROS')),        
        
      ),
    );
  }

}