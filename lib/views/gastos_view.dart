import 'package:dam38_appgastospersonales/model/cuentaGastos.dart';
import 'package:dam38_appgastospersonales/repositories/repository_cuenta_gastos.dart';
import 'package:dam38_appgastospersonales/views_test/conteiner1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//importar debugPaintSizeEnabled class

class GastosView extends StatefulWidget {
  const GastosView({super.key,required this.title});
  final String title;
  @override
  State<GastosView> createState() => _GastosViewState();
  
}

class _GastosViewState extends State<GastosView> {
  
  final repositoryCuentaGastos=RepositoryCuentaGastos();
  List<CuentaGastos> _GastosList = [];  
  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    if (_GastosList.isEmpty) {
      _cargarListGastos();
    }
    
    return SafeArea( 
      child: Scaffold(
        
        appBar:registroAppBar(),         

        body: Container(
          //CONFIGURACION CONTENEDOR
          color: const Color.fromARGB(255, 190, 239, 243),
          padding: const EdgeInsets.all(10),
          //TERMINANA CONFIGURACION CONTENEDOR
          //*********************************************** */
          //en esta vista estara el view principal que contendra la 
          //child: ListViewTest(),
          child: Column(
          //mainAxisAlignment:MainAxisAlignment.spaceAround,
          //mainAxisSize: MainAxisSize.max,        
            children: [
              
              Container(
              width: MediaQuery.of(context).size.width, 
              color: const Color.fromARGB(255, 135, 159, 236),
              padding: const EdgeInsets.all(5),  
              child: const Text('RESUMEN FINANCIERO'),
              ),
              
              Conteiner1(),

              Container(
              width: MediaQuery.of(context).size.width, 
              color: const Color.fromARGB(255, 135, 159, 236),
              padding: const EdgeInsets.all(10),  
              child: const Text('REGISTROS DE GASTOS'),
              ),
              
              Expanded(
                child: getListGastosView(),
                
                ),
              
              
            ],
         ),           
        ),
      ),
    ) ; 
  }
  
  ListView getListGastosView() {
    return ListView.builder(
      itemCount: _GastosList.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: ListTile(
            leading: Icon(getTipoGastoIcon(_GastosList[index].tipoGasto.getIdTipoGasto()),
              color: const Color.fromARGB(255, 248, 145, 114),
              ),
            title: Text(_GastosList[index].getDescripcion()),          
            subtitle: Text(_GastosList[index].dateString(),style: TextStyle(fontSize: 12,)),
            trailing:SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [                  
                  Text('\$ '+_GastosList[index].getMonto(),
                    style: TextStyle(
                    fontSize: 15, // Tamaño de la fuente en píxeles
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Icon(Icons.delete, color: Colors.grey,),
                    onTap: () {
                      _deleteGasto(context, _GastosList[index]);
                      //_delete(context, noteList[position]);
                    },
                  ),
                  
                ],
              ),
            ),
             //Text(_GastosList[index].monto.toString()),
          ),
        );
      },
    );
  }
  AppBar registroAppBar  ()  {
    //final usuarios = await repositoryUsuario.listUsuarios();
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 248, 145, 114),
      title: Text(widget.title),
      actions: [
        //Text('BIENVENIDO: DIONISIO GARCIA'),
        IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'menu',
          onPressed: () {
            //Navigator.pushNamed(context, '/nuevo');
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    );
  }
  void _deleteGasto(BuildContext context, CuentaGastos cuentaGastos) async {
    int result = await repositoryCuentaGastos.deleteById(cuentaGastos.idgasto);
  //  showDialog(
  if (result != 0) {
      ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(
            backgroundColor: const Color.fromARGB(255, 248, 145, 114),
            content: Text("Gasto Eliminado: ${cuentaGastos.getDescripcion()}")
          )
        );
			
      _cargarListGastos();
		}
  }
  void _cargarListGastos()  {
    Future <List<CuentaGastos>> listGastos=repositoryCuentaGastos.listCuentasGastos();
    listGastos.then((value) {
      setState(() {
        _GastosList = value;        
      });
    });   
  } 
  IconData getTipoGastoIcon(String codigoTipo) {
		switch (codigoTipo) {
			
      case "001":
				return Icons.food_bank_outlined;
        //break;				
			case "002":
				return Icons.emoji_transportation;
        //break;
      case "003":
				return Icons.house_outlined;
        //break;
      case "004":
				return Icons.health_and_safety_outlined;
        //break;
      case "005":
        return Icons.school_sharp;
        //break;
      case "006":
        return Icons.gamepad_outlined;
        //break;
      case "007":
        return Icons.payments_outlined;
        //break;
      case "008":
        return Icons.account_balance_wallet;
				//break;

			default:
				return Icons.device_unknown;
		}
	}
}