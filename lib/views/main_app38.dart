import 'package:dam38_appgastospersonales/viewmodels/repositories_data.dart';
import 'package:flutter/material.dart';

class MyApp38 extends StatelessWidget {
  MyApp38({super.key});
  //final bdTest=BaseDatoTest();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter de saqlite Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 173)),),
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
            //ElevatedButton(onPressed: (){;}, child: const Text('Mostrar')),
            //ElevatedButton(onPressed: (){;}, child: const Text('borar lastUsuario')),
            //ElevatedButton(onPressed: (){_borrarTabla();}, child: const Text('borar tabla')),
            
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              '$_oposivecounter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add)
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}