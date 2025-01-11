class ApiConstantes {
  static const String MODULO = "app-elecciones";
  static const String AUTH = "v1-auth";


  //OBTENER LA IMAGEN DE PROCESO ACTIVO
  static const ELECCIONES_PROCESOS_ACTIVOS_IMG = "v1-proceso-activo-img"; //f24a0c023c07526f2b99ce54be2ab798
  static const ELECCIONES_PROCESOS_ACTIVOS = "v1-proceso-activo"; // 689a384a92f51e89f6916f146c3cbb25
  static const ELECCIONES_SERVICIOS_ACTIVOS = "v1-servicios-activo"; // 1e5ce7ad42482403d3dc5b3eba80e97b

  static const ELECCIONES_UNIDADES_POLICIALES = "v1-unidades-policiales"; // bbc1a27d5d33236b1ae4100a33b5f2e9
  static const ELECCIONES_RECINTOS_ELECTORALES = "v1-recintos"; // 54a659659dff3975495d80543ea33c71
  static const ELECCIONES_TIPOS_EJES_BY_ID_PADRE = "v1-ejes-by-id-padre"; // 0934eca05bce3f4f96999f3fa15ec6aa
  static const ELECCIONES_CREAR_CODIGO = "v1-crear-code"; // a85db6756be28494370fbb860621ef8b

  static const ELECCIONES_PERSONA_BY_CEDULA = "v1-persona-cedula"; // c996291faac0d749d702ba290948dcd8
  static const ELECCIONES_RECINTO_ADD_PERSONA = "v1-recinto-add-persona"; // 7fd3b86402efccdf476a77bf120ec3cc
  static const ELECCIONES_RECINTO_GET_PERSONAL = "v1-recinto-persona"; // b3c995b78182ffb79e73789755776355



  //************************** CONSULTAR PARA SABER SI EL USUARIO SE ENCUENTRA ASIGNADO A UN RECINTO ELECTORAL ********************************************************
  //verificar segun el idpersona para saber si se encuentra asignado a un recinto electoral  es para saber si es personal designado o es jefe
  static const ELECCIONES_VERIFICA_PER_ASIGNADO_REC_ELECT = "v1-verifica-per-asignado-rec-elect"; //f24a0c023c07526f2b99ce54be2ab798
}
