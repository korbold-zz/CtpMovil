import 'package:ctp1/core/Services/clientes_api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ClientesApi('products'));
}