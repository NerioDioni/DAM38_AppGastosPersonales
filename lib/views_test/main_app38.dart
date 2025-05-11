import 'package:dam38_appgastospersonales/viewmodels/repositories_data.dart';
import 'package:dam38_appgastospersonales/views_test/view_login.dart';
import 'package:flutter/material.dart';

class MyApp38 extends StatelessWidget {
  MyApp38({super.key});
  //final bdTest=BaseDatoTest();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Registro Gastos Personales',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 86, 165, 41)),),
      home:  MyHomePage(title: 'Flu Demo db Sqlite Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final repositoriesData=repositoriesdataViewModel();
  //final repositorydatos =RepositoryUsuario();
  int _counter = 0;
  int _oposivecounter = 0;
  void _incrementCounter() {
    setState(() {      
      _counter++;
      _oposivecounter--;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //debugPaintSizeEnabled: true,
      appBar: AppBar(       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(onPressed: (){repositoriesData.printAllRepositories();},
              child: const Text('Imprimir todos los repositorios')),
            ElevatedButton(onPressed: (){repositoriesData.printAllRepositories();},
              child: const Text('Imprimir todos los repositorios')),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewLogin(),
                  )     ,
                );
              },
              child: const Text('vista login')),
            
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewLogin(),
                  ),
                );
                },
        tooltip: 'Nuevo Registro',
        child: const Icon(Icons.add)
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}