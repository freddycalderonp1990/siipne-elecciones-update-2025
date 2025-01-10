import 'dart:async';


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart' as myGeolocator;
import 'package:get/get.dart';

import '../../app_elecciones/domain/enums/enums.dart';

class AppConfig {
  static var AmbienteUrl=getAmbiente( dotenv.env['AMBIENTE']??'DEV');

  static bool isUserGoogleOrIos=false;
  static bool activarMocks=false;
  static int secondsTimeout=8;

  static  int duracionQRDay =  3; //duracion en minutos que dura el QR tanto al compartir como el web 1 hora
  static  int duracionSolicitarAccesoHuellaPin =  120; //tiempo en segundos antes de solicitar otra vez la huela

  static  String formatoFecha =  'yyyy-MM-dd';
  static  String formatoHora =  'HH:mm';

  static const String nameAppSiipne3w="SIIPNE-3W";
  static const String key_securiry_qr="*dG@p5Yh%j6BwTEGO";

  static const double radioBotones = 15.0;

  static StreamSubscription<myGeolocator.Position>? positionSubscription;



  static const double radioBordecajas = 15.0;
  static const double sobraBordecajas = 12.0;

  static const double tamTextoTitulo = 2.0; //tamaño del texto en porcentaje
  static const double tamTexto = 1.5; //tamaño del texto en porcentaje
  static const double tamIcons = 2.5; //tamaño de los iconos en porcentaje

  static const double anchoContenedor = 90.0;


  //VARIABLES PARA LOS OPERATIVOS DEL SIIPNE

  //OPERATIVOS POLCO

  //SIRVE PARA CARGAR LOS TIPOS DE OPERATIVOS SEGUN LOS OPERATIVOS POLCOS
  static const int idGenTipoTipificacionEcu_OperativoPolco  = 21271; //21271=OPERATIVO SERVICIO URBANO
  //Nota: idGenTipoTipificacionEcu
  //Es un código que viene del ECU911 con la información preliminar del tipo de tipificación del evento. Es decir, aqui viene
  // un id del Ecu que es el mismo en nuestra base de datos tabla genTipoTipificacion,  que identifica el tipo de incidente preliminar
  // que no necesariamente es el real.
  //El idGenTipoTipificacionEcu=21271 corresponde al OPERATIVO SERVICIO URBANO,




  //esta variable sirve para identificar el operativo que seleciona el usuario en la pantalla donde se cargan todos los operativos
  //segun este id carga el operativo polco (Consulta de personas y vehículos)
  static const int idGenModulo_OperativoPolco  = 44; //Móviles Operativos Polco (37=Pruebas, 44Desarrollo, )
  //Obtiene los tipo de tipificaciones de la tabla genTipoTipificacion segun el operativo polco



  //VARIABLES PARA OPERATIVOS RELACIONALES


  static const Duration defaultDuration = Duration(milliseconds: 300);




  static RxBool errorUbicacion=true.obs;
  static RxBool ubicacionLista=false.obs;

  static bool plataformIsIos=false;

  static bool mostrarAnuncios=true;

  static bool isAdLoadedOnceBanner = false; // Bandera para controlar si el anuncio se cargó


  static getAmbiente(String ambiente){
    if(ambiente=='DEV'){
      return Ambiente.desarrollo;
    }
    else if(ambiente=='TEST'){
      return Ambiente.prueba;
    }
    else if(ambiente=='PROD'){
      return Ambiente.produccion;
    }
  }


}
