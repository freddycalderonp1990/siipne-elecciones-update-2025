




import 'saveFile/di.dart';
import 'user/di.dart';

class DependencyInjectionFeactures {

  static init(){

    DependencyInjectionUser.init();
    DependencyInjectionSaveFile.init();


  }



}