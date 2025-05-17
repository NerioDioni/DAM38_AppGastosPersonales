import 'package:dam38_appgastospersonales/model/cuentaGastos.dart';
import 'package:dam38_appgastospersonales/model/tipo_gasto.dart';
import 'package:dam38_appgastospersonales/model/tipo_pago.dart';
import 'package:dam38_appgastospersonales/repositories/repository_cuenta_gastos.dart';
import 'package:dam38_appgastospersonales/repositories/repository_tipo_gasto.dart';
import 'package:dam38_appgastospersonales/repositories/repository_tipo_pago.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';


class DetailGastosView extends StatefulWidget {
 
 final String appBarTitle;
 final CuentaGastos gasto;
 
 const DetailGastosView({
    super.key,
    required this.appBarTitle,
    required this.gasto,
 });
 @override
 //State<FormGastosView> createState()=> _FormGastosViewState(this.appBarTitle, this.cuentaGastos);
  State<DetailGastosView> createState() => _DetailGastosViewState(this.appBarTitle, this.gasto);
 }

class _DetailGastosViewState extends State<DetailGastosView> {
  final repositoryTipoGasto=RepositoryTipoGasto();
  final repositoryTipoPago=RepositoryTipoPago();
  final repositoryCuentaGasto=RepositoryCuentaGastos();
  List<TipoGasto> tipoGastosList = [];
  List<TipoPago> tipoPagoList=[];
  String appBarTitle;
  CuentaGastos gasto;
   DateTime? selectedDate;
  final _formGlobalKey = GlobalKey<FormState>();
  TextEditingController _controllerMonto = TextEditingController();
  TextEditingController _controllerDescripcion = TextEditingController();
  DateTime _controllerFecha=DateTime.now();
  String? _controllerTipoPago="";
  String? _controllerTipoGasto="";
  CuentaGastos? gastoNull;

  
  //String _errorText = "";
   _DetailGastosViewState(this.appBarTitle, this.gasto);
 
 @override
  void initState() {
    
    super.initState();
    cargarLists();
  }
  @override
  Widget build(BuildContext context) {
   // debugPaintSizeEnabled = true;
    print("controllerDescripcion : ${_controllerDescripcion.text} " );
    print("controllerfecha : ${_controllerFecha.toString()} " );
    print("controllermonto : ${_controllerMonto.text} " );
    print("controllertipogasto : $_controllerTipoGasto" );
    print("controllertipoPago : $_controllerTipoPago" );
    print("***************objeto gasto inicial : ${gasto}"); 
    return SafeArea( 
      child:Scaffold(
        appBar: registroAppBar(widget.appBarTitle),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(               
            children: [
              Expanded(
                child: Form(
                  key: _formGlobalKey,
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //fila donde ira tipo_gastolist y tipo_pagolist
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child:DropdownButtonFormField(                                 
                              value:_controllerTipoGasto,
                              decoration: const InputDecoration(
                                labelText: 'Tipo de Gasto',                                
                                border: OutlineInputBorder(),                                                    
                              ),
                              items:tipoGastosList.map(
                                    (g)=> DropdownMenuItem(                                      
                                      value: g.getIdTipoGasto(),
                                      child:Row(
                                        mainAxisAlignment:MainAxisAlignment.start,                                        
                                        children: [
                                        Icon(getIconTipoGasto(g.getCodigoTipoGasto())),                                        
                                        Text(g.getNombre()),                                        
                                        ])
                                    )
                              ).toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo requerido';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                
                                setState(() { 
                                   _controllerTipoGasto=value;                                    
                                });
                              },
                            ),
                          ),
                          Expanded(child:DropdownButtonFormField( 
                              value:_controllerTipoPago,
                              decoration: const InputDecoration(
                                labelText: 'Tipo de pago',
                                //hintText: '',
                                border: OutlineInputBorder(),                        
                              ),
                              items:tipoPagoList.map(
                                    (p)=> DropdownMenuItem(                                      
                                      value: p.getIdTipoPago(),
                                      child:Row(
                                        mainAxisAlignment:MainAxisAlignment.start,                                      
                                        children: [                                         
                                        Text(p.getNombre()),                                        
                                        ])
                                    )
                              ).toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo requerido';
                                }
                                return null;
                              },
                              onChanged: (value) {                                
                                setState(() {
                                  _controllerTipoPago=value;                                    
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _controllerDescripcion,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          labelText: 'Descripcion',
                          //hintText: 'Descripcion del gasto',
                          border: OutlineInputBorder(),                        
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        onChanged: (value) {                               
                          setState(() { 
                            _controllerDescripcion.text =value;                                                        
                          });
                        },
                      ),
                      
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _controllerMonto,                      
                        decoration: const InputDecoration(
                          hintText: "Ingrese el monto",
                          labelText: "Monto",
                          //errorText: _errorText,
                          border: OutlineInputBorder(),   
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            String newText = newValue.text;
                            if (newText.contains(',')) {
                              newText = newText.replaceAll(',', '.');
                            }
                            if (newText.startsWith('.')) {
                              newText = "0$newText";
                            }
                            return TextEditingValue(
                              text: newText,
                              selection: newValue.selection,
                            );
                          })
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo requerido';
                          } else if (double.tryParse(value) == null) {
                            return 'Ingrese un número válido';
                          }else if (double.tryParse(value)! < 0.01) {
                            return 'Ingrese un número válido > 0.01';
                          }else if (double.tryParse(value)! > 9999999.99) {
                            return 'Ingrese un número válido < 9999999.99';
                          }


                          return null;
                        },    
                        onChanged: (value) {                               
                          setState(() { 
                            _controllerMonto.text =value;                                                        
                          });
                        },                                                                 
                      ),                     

                      const SizedBox(height: 15),
                      InputDatePickerFormField(
                        //final year=DateTime.now.year,
                        firstDate: DateTime(2020), // Fecha mínima permitida
                        lastDate: DateTime(DateTime.now().year+1), // Fecha máxima permitida
                        initialDate: _controllerFecha , // Fecha inicial mostrada
                        errorInvalidText: "La fecha no es válida", // Mensaje de error
                        errorFormatText: "La fecha no tiene el formato correcto", // Mensaje de error
                        fieldLabelText: "Fecha: mm/dd/yyyy (-años permitidos: 2020 hasta actual/curso)",
                        acceptEmptyDate: false,
                        onDateSubmitted: (date) {                          
                          setState(() {
                            _controllerFecha = date;
                            gasto.setFecha(_controllerFecha);
                          });
                        },
                        /*onDateSaved:(date) {                          
                          setState(() {
                            _controllerFecha = date;
                          });
                        } ,*/
                      ) ,
                      const SizedBox(height: 30), 
                      FilledButton(
                        onPressed: (){
                          if (_formGlobalKey.currentState!.validate()) {
                            save();
                          }
                          
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 248, 145, 114),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ), 
                        child: const Text('Guardar'),
                      ),
                                             
                    ],                    
                  ),
                ),               
              ),
            ],
          ),

        )
        
      ),
    );
  }
  void save () async{
    moveToLastScreen();
    int result;
    gasto.setDescripcion(_controllerDescripcion.text);
    gasto.setMonto(double.parse(_controllerMonto.text));  
    gasto.setFecha(_controllerFecha);
    final id_TipoPago=int.parse(_controllerTipoPago.toString()) ;
    final id_tipoGasto=int.parse(_controllerTipoGasto.toString()) ;
    TipoPago  newTipoPago= tipoPagoList.firstWhere(
      (tipoP)=>tipoP.idTipoPago==id_TipoPago, ) ;
    TipoGasto newTipoGasto= tipoGastosList.firstWhere(
      (tipoG)=>tipoG.idTipoGasto==id_tipoGasto, ) ;  
    gasto.setTipoGasto(newTipoGasto);
    gasto.setTipoPago(newTipoPago);
    
    
    if (gasto.idgasto > 0) {  // Case 1: Update operation
		  result= await repositoryCuentaGasto.actualizarGasto(gasto);
      if (result != 0) {  // Success
			  _showAlertDialog('Status', 'Gasto Update Successfully');
		  } else {  // Failure
			  _showAlertDialog('Status', 'Problema Updating Gasto');
  		}
		} else { 
      result= await repositoryCuentaGasto.insertGasto(gasto);
      if (result != 0) {  // Success
		  	_showAlertDialog('Status', 'Gasto Insert Successfully');
		  } else {  // Failure
			  _showAlertDialog('Status', 'Problema Updating Gasto');
		  }
		}
    //print("***************objeto gasto modificado : ${gasto}");

    

 }

  void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}


  AppBar registroAppBar  (String title)  {
   
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 248, 145, 114),
      title: Text(title),
      actions: [
        
      ],
    );
  }

  void cargarLists ()  {
    Future <List<TipoGasto>> listTipoGastos=repositoryTipoGasto.listTipoGastos();
    Future <List<TipoPago>> listTipoPagos=repositoryTipoPago.listTipoPagos();  
    
    listTipoPagos.then( (value){
      setState(() {
        tipoPagoList = value;        
      });
    });
    listTipoGastos.then( (value){
      setState(() {
        tipoGastosList = value;        
      });
    });
    if(gasto.idgasto==-1){
      _controllerTipoGasto=null;
      _controllerTipoPago=null;

    }else{
      _controllerMonto.text = gasto.getMonto();
      _controllerDescripcion.text = gasto.getDescripcion();
      _controllerFecha= gasto.fecha;
      _controllerTipoGasto=gasto.tipoGasto.getIdTipoGasto();
      _controllerTipoPago=gasto.tipoPago.getIdTipoPago();
    }
  }
  IconData getIconTipoGasto(String codigoTipo) {
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

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }
  
 

}