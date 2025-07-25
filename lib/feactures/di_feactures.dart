




import 'app_moviles/di.dart';
import 'foto_dgp/di.dart';
import 'save_file/di.dart';
import 'user/di.dart';

class DependencyInjectionFeactures {

  static init(){

    DependencyInjectionUser.init();
    DependencyInjectionSaveFile.init();
    DependencyInjectionAppsMoviles.init();
    DependencyInjectionFotoDgp.init();


  }


}