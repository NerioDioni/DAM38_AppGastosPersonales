import 'package:dam38_appgastospersonales/model/cuentaGastos.dart';
import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/model/usuario.dart';
import 'package:dam38_appgastospersonales/repositories/repository_cuenta_gastos.dart';
import 'package:dam38_appgastospersonales/repositories/repository_usuario.dart';
import 'package:dam38_appgastospersonales/views/detalle_gastos_view.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//importar debugPaintSizeEnabled class

class GastosView extends StatefulWidget {
  const GastosView({super.key,required this.title});
  final String title;
  @override
  State<GastosView> createState() => _GastosViewState();
  
}

class _GastosViewState extends State<GastosView> { 
  final repositoryCuentaGastos=RepositoryCuentaGastos();
  final repositoryUser=RepositoryUsuario();
  int idUsuarioApp=3;
  List<CuentaGastos> _gastosList = [];
  List<Map<String,Object?>> _monthByYearList=[];
  String _controlllerMes="";
  String _controllerAnio="";
  var dropDownValue;
  double _montoGastoMesAnio=0;
  
  @override
  void initState() {
    super.initState();
    _cargarMonthBYyearList();
        
  }
  
  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    
    return SafeArea( 
      child: Scaffold(        
        appBar:registroAppBar(),         
        body: Container(
          //color: const Color.fromARGB(255, 243, 221, 245),
          padding: const EdgeInsets.all(10),              
          child: Column(      
            children: [              
              Container(
              width: MediaQuery.of(context).size.width, 
              color: const Color.fromARGB(255, 205, 215, 247),
              padding: const EdgeInsets.all(10),  
              child: const Text('RESUMEN FINANCIERO'),
              ),
              Container(
                width: MediaQuery.of(context).size.width, 
                //color: const Color.fromARGB(255, 205, 215, 247),
                padding: const EdgeInsets.all(10), 
                child:Row( 
                    children: [ 
                      DropdownButton(
                        value: dropDownValue,
                        icon:const Icon(Icons.arrow_downward),
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                        padding: const EdgeInsets.all(10),                  
                        items: _monthByYearList.map(
                          (mapa)=> DropdownMenuItem(  
                            value: mapa['id'],
                            child: Text("periodo: ${mapa['anio']}/${mapa['mes']}"),
                          )
                        ).toList(),
                        onChanged: (value){
                          setState(() { 
                          dropDownValue=value;
                          setAnioMes();
                          _cargarListGastos();

                          });
                        }
                      ),
                      Column(
                        children: [
                          Text("MONTO DE GASTOS "),
                          Text("${_montoGastoMesAnio.toStringAsFixed(2)}"),
                        ],
                      ), 
                ]
                ),  
              ),
              //Conteiner1(),

              Container(
              width: MediaQuery.of(context).size.width, 
              color: const Color.fromARGB(255, 205, 215, 247),
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
      itemCount: _gastosList.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          
          child: ListTile(
            leading: Icon(getTipoGastoIcon(_gastosList[index].tipoGasto.getCodigoTipoGasto()),
              color: const Color.fromARGB(255, 248, 145, 114),
              ),
            title: Text(_gastosList[index].getDescripcion()),          
            subtitle: Text(_gastosList[index].dateString(),style: TextStyle(fontSize: 12,)),
            trailing:SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [                  
                  Text('\$ '+_gastosList[index].getMonto(),
                    style: TextStyle(
                    //fontSize: 15, // Tamaño de la fuente en píxeles
                    ),
                  ),
                  //Spacer(),
                  GestureDetector(
                    child: Icon(Icons.delete, color: Colors.grey,),
                    onTap: () {
                      _deleteGasto(context, _gastosList[index]);
                    },
                  ),
                ],
              ),
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              _navigateToDetail(
                'Editar Gasto',
                _gastosList[index],
              );                         
            },
          ),
        );
      },
    );
  }
  AppBar registroAppBar  ()  {
    
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 248, 145, 114),
      title: Text(widget.title),
      actions: [  
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'nuevo registro',
          onPressed: () {
             _navigateToDetail(
                'Nuevo Gasto',
                null,
              ); 
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
			_cargarMonthBYyearList();
      //_cargarListGastos();
		}
  }
  void setAnioMes(){
    var periodoMap= _monthByYearList.firstWhere(
          (map)=>map['id']==dropDownValue,
        ) ;
    setState(() {
    _controllerAnio=periodoMap['anio'].toString();
    _controlllerMes=periodoMap['mes'].toString();    
      
      });

  }
  void _cargarMonthBYyearList() async{
   final listMontByYearList= await repositoryCuentaGastos.getListMonthByYearByUser(idUsuarioApp); 
    if(listMontByYearList.isNotEmpty){
      setState(() {
      _monthByYearList=listMontByYearList;
      dropDownValue=_monthByYearList[0]['id'];
      _controllerAnio=_monthByYearList[0]['anio'].toString();
      _controlllerMes=_monthByYearList[0]['mes'].toString();
      
      _cargarListGastos();
        });
    }else{
      setState(() {
      _monthByYearList=[];
      dropDownValue="";
      _controllerAnio="";
      _controlllerMes="";
      _cargarListGastos();
        });



    }
  }

  void _cargarListGastos()async  {   
    final listgastos= await repositoryCuentaGastos.listCuentasGastosBYUser(idUsuarioApp,_controllerAnio,_controlllerMes);   
    var montoMap=await repositoryCuentaGastos.totalGastosMesByAnio(idUsuarioApp,_controllerAnio,_controlllerMes);
    setState(() {
      _gastosList =listgastos;
      if(montoMap.isNotEmpty&&montoMap['total_mes']!=null){
        _montoGastoMesAnio=double.parse(montoMap['total_mes'].toString());     
      }else{
        _montoGastoMesAnio=0;
      }
      //var map=_monthByYearList[0];
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


  void _navigateToDetail(String title,CuentaGastos? regGasto) async {
	  if(regGasto!=null){    
      var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailGastosView(
          appBarTitle: title,
          gasto: regGasto!,
        );
      }));

      if (result == true) {
        _cargarMonthBYyearList();
        //_cargarListGastos();
      }
    }else if (regGasto==null){
      final user=await repositoryUser.getUsuarioById(idUsuarioApp);
      regGasto=CuentaGastos(
        idgasto: -1,
        descripcion: 'nuevo',
        fecha: DateTime.now(),
        monto: 0.0,
        tipoGasto: TipoGasto(idTipoGasto: 0, nombre: 'No encontrado', Codigo: 'No encontrado'),
        tipoPago:  TipoPago(idTipoPago: 0, nombre: 'No encontrado'),      
        usuario: user,
      );
      var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailGastosView(
          appBarTitle: title,
          gasto: regGasto!,
        );
      }));

      if (result == true) {
        _cargarMonthBYyearList();
      }
		}

  

  }

}