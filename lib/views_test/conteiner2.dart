import 'package:flutter/material.dart';

class Conteiner2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Expanded( 
        child: ListView(
         children: [
            Column( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                    Icon(Icons.kitchen, color: const Color.fromARGB(255, 67, 73, 67)),
                    const Text('PREP:'),
                    const Text('25 min'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.timer, color: const Color.fromARGB(255, 74, 80, 75)),
                      const Text('COOK:'),
                      const Text('1 hr'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.restaurant, color: const Color.fromARGB(255, 80, 85, 81)),
                      const Text('FEEDS:'),
                      const Text('4-6'),
                    ],
                  ),
                ],//final principal row2              
              ),                    
          ],
        ),     
      //),
    );
  }
}