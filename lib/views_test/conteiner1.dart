import 'package:flutter/material.dart';

class Conteiner1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: const Color.fromARGB(255, 223, 230, 131),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          //principal row1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.max,
            children: [
              Column(  
                children: [
                  Icon(Icons.star, color: const Color.fromARGB(255, 63, 136, 78)),
                  const Text('RATING:'),
                  const Text('4.5'),
                ],
              ),
              Column(  
                children: [
                  Icon(Icons.star, color: const Color.fromARGB(255, 63, 136, 78)),
                  const Text('RATING:'),
                  const Text('4.5'),
                ],
              ),
              Column(  
                children: [
                  Icon(Icons.star, color: const Color.fromARGB(255, 63, 136, 78)),
                  const Text('RATING:'),
                  const Text('4.5'),
                ],
              ),
            ],
          ),
          //principal row2
          
        ],
      ),
    );
  }
}