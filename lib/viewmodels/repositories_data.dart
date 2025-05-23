import 'package:dam38_appgastospersonales/repositories/repository_cuenta_gastos.dart';

import 'package:dam38_appgastospersonales/repositories/repository_tipo_gasto.dart';
import 'package:dam38_appgastospersonales/repositories/repository_tipo_pago.dart';
import 'package:dam38_appgastospersonales/repositories/repository_usuario.dart';

class repositoriesdataViewModel {
  final repositoryUsuario = RepositoryUsuario();
  final repositoryTipoPago = RepositoryTipoPago();
  final repositoryTipoGasto = RepositoryTipoGasto();
  
  final repositoryCuentaGastos = RepositoryCuentaGastos();

  //imprimir todos loss repositorios 1 por 1
  //cada repositorio tiene su metodo print para imprimir una lista de objetos segun su tipo
  Future<void> printAllRepositories() async {
    print('------------usuarios-------------------');   
    //await repositoryUsuario.printUsuarios();
    await repositoryUsuario.setListUsuarios();
    print('------------tipoPagos-------------------');
    await repositoryTipoPago.printTipoPagos();

    print('-----------------tipoGastos--------------');    
    await repositoryTipoGasto.printTipoGastos();

    
    
    print('---------------CuentaGastos----------------');
    await repositoryCuentaGastos.printCuentasGastos();
    print('-------------------------------');

  }

}