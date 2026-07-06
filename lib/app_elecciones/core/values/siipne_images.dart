import 'package:get/get.dart';

class SiipneEleccionesImages {


  static RxString imgCabeceraProceso = "".obs;


  static const rutaImg = "assets/elecciones/img/";
  static const rutaIcon = "assets/elecciones/icon/";

  //-*********************** ICONOS *******************************
  static const iconNoImg = rutaIcon + "icon_no_img.png";
  static const imgCamaraD = rutaImg + "camara.png";
  static const imgFotosD = rutaImg + "fotos.png";

  static const icon = rutaIcon + "icon.png";
  static const icon_abrir_rec_elec =
      rutaIcon + "icon_abrir_rec_elec.png";
  static const icon_eliminar_rec_elec =
      rutaIcon + "icon_eliminar_rec_elec.png";
  static const icon_finalizar_rec_elec =
      rutaIcon + "icon_finalizar_rec_elec.png";
  static const icon_registrar_novedades_rec_elec =
      rutaIcon + "icon_registrar_novedades_rec_elec.png";

  static const icon_unidades_policiales =
      rutaIcon + "icon_unidades_policiales.png";


  static const icon_anexarse_rec_elec =
      rutaIcon + "icon_anexarse_rec_elec.png";

  static const icon_abandonar_rec_elec =
      rutaIcon + "icon_abandonar_rec_elec.png";
  static const icon_agregar_personal =
      rutaIcon + "icon_agregar_personal.png";
  static const icon_usuario = rutaIcon + "icon_usuario.png";
  static const icon_usuario2 = rutaIcon + "icon_usuario2.png";
  static const icon_clave = rutaIcon + "icon_clave.png";

  static const icon_huella = rutaIcon + "icon_huella.png";

  static const ic_elecciones = rutaIcon + "ic_elecciones.png";
  static const ic_validar_recinto= rutaIcon + "ic_validar_recinto.png";

  //Imagen en base64
  static const imgNoImagen =
      'iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAYAAADimHc4AAAABmJLR0QA/wD/AP+gvaeTAAAKnElEQVR4nO2daWwc1R3Af29mvd7DdxwngSR27KTKIQhQlFiFLy3FCVUhUWlBKh8LFKFCaQsqIUQqaiAVEGjoQTGID9w0iBBFlARoOQqIhKYIELlwiDdx0tjxvd5zjtcPaxuv7ezM7o6PdeYnRfK8fe/5ZX7zf9fOjMHFxcXFxcXFxcVl0lGzzC9WN617cEHD0v62o4dPTkiLzjGULPKKxjXrH0NwlxTsWX3V1Y0T1qpzCGE3X+Oa9Y9J5C9GpPWhmGv3vrHr44lo2LmCnQgQq9au2zbq5AOUYyq73UjID6sIEKvWrtsmJLdlyONGQh5kjIDGNdf8weLkw2AkNDatW+1gu84ZMgqQUvk70GOjnnJ3YM4Ny0F4ddP6byPkW0ClVV5FUZi9oBavL+BI4wqECFK2IsSbQsqntv9py4FsCtuaBbkSbGMg5F+qYl13Njc3a3YK2FoHLPzORV/ULKj9SlGs122maXLmRIhkPGqn6pmGihS3d/uqX7/55puL7BSwJcDsSmwtDpSsmr2gDleCLa7s8lU/ZCejZRd07a82rRCG8RmD2xbJeJzOthCGoVtWHgz42bzhNyxd3GCnLQVJPJnk4NEQr779Pu1dafMVXVWUC1/+4+aDmcpbRoAw9RsZsWc0p2Y2WzbeRUkwaNm4SDTGvVu2cqjlqGXeQsXn9XLxsiXcfeMNVJaVjvzIo5vGjVblrbsgKZpGHl5/1fe4YNm3eOCeO10JIwj6fVy39rtpaQrp52487IwBC0YeLG+oBWBJfZ0rYRQrGurSjiXUWpWxIyAtrnxe7/DProR0fMXe0Uml4+UbSTbb0ePiSsiPvAWAKyEfHBEAroRc8ThZ2ZL6Otqv2Ujg1fsRiUjGvJFojDs2byW6fgPG3CVONmNC+bAx7mh9jkXAEEbNIqI/2ogsto4EkYgReG0L6umvnG5GweC4AHAlZMOECABXgl0mTAC4EuwwoQLAlWCFo7MggNqgoGhwj1WTkqgu6JubkmBndjQkYWh2VKRARZHAr4J38HLRJUR1SZ8mSJgy57bO9fZxd/0eLqtITYc/7l3EI6HvcyxWnXOd2eJ4BBQroIjUv2JFUOmFuqCgckE9sSwjYVZXC3WBVB0+9Zt6vQpUeAULA1Djs39z00jmevvYcfHfaJp1gKCaIKgmuGLWIV688CnmevtyqDE3JrwLGqLKCzW19WjXbgSfPQnG9i3op87eHQmRio7zAtlLuKdhD+We2Jj0Mk+cDfVvZllb7kyaAIASDyysr2fWDfcibEgwE1F6XtiCdjLzmBBUBVXF9toggOpiMdztjMdllUepKc4tsrJlUgUMUTRvEVUOS6gqEtT4oDYAS0oFS0oFdUFBTfE3Y4cQMM+fisaMyMEuLiioDabqW1wiqA06r2RKBIDzEoa6o2JVIEhdvUNjRW1AMLtYMMsrKPGkTuLn4UVnrevTgdRXqMVKahwTDI1p2fwP7TFlAmBiImE8hIBKb/qV/8zpKxkwfGPyhg0/T59am/XvyJUpFQCTJ2E0JxPV3HHkVj7sW0HU9BE1fXzYt4I7jtxKl1aWd/12cXwdkBlJsvtltPA/ASgquwJv5fXDErqf34yMZ14nDEmo/OkGis7Pbxe1UyvnodB1edWRL5MaAcnenSR7XkLqZ5D6GZLdL5Hs3QlMXSRMNZMmwEweJ9n9wph0red5FnpCrKxQuHTZYi65aROqv8S6vkEJ4vRXzPcLlpWpXFShsrJCYVmZyvl+gW/KO1hrJqeJUiPe/gjI5NiPTI3W4w8DGqqAOXUNNN6yCY9NCZ3PbcHb3oJ/cKWsitS2xRyfwvLylIjJmM/niuMC5vkUlpYqrKxQWVmhsrRUoaj/Wcxk61nLRGMnaG17dvi4fH49q2/ZRJENCVo8yifN99MbOjLu53N8Cg0lCgLwCMF5Q9FSmWrfsjKFeX6BR5xdk0cI5vkES0udv16dF+AXBDwCVYAqIBn9nJ6uXZblTrXvpKdv//Bx+fx6VjkkoaxI0FCisLxcMNenpKKFVPv8qmCeT2FFuUKFd6yECi+sKBfM8ysEPAW2ENONAQ63bgNpvWMpkRxpfQxdDw+nOS0h01WuClgUVAbHkVTkLgwoLAqqqBnK5cuECmgJ/ZVE8ozt/AmtmyOhP6elOSnBiqEVryog4BFUF0/8+DFhAjq63qWj+99Zl+vs+YiOrvfS0rKVsPeJ39ETOpz1754KJkRAQuvi6PEnci7fcvxx4on0yMlGgpHQ2Nd8X86RMJk4L0BKDh97FM0YyLkK3YhwuHUrEjMtfVhCwIaEuMa+5t9PewmOC2hr30Fv/2d519MX/pK29tfGpJfPr2f1z+1J0ONx9jVvntYSHBfQeuo5x+oKnXyOSGzs+qFsUILqs34MS4/HbA/MEkn/wG5Od9zH6Y77CId3I8n9O2c7OC7ANG09HGi7roNfP4gxzgqaqghlP9QRNr4Jszs7Goi8Qzi8G8PowTB66B/YzUDknRxbb49pv1sSjZ0gNGKVDGCYEY61P46nGiquxhEJmn6acPiNMenh8D/QtFM5td0O014AQFvHzrRxJdTxJEm9EwBPtchbgpQ6PT3PIOXY6JVSp7v3GSTORfZICkJAamb1CLoepqv/A7rCH6V9nK+E/vAuNP3sV7mun6a///Wcm5+JwhBAapV8qPVRjp95etzPc5WQSBxhIPq+ZZlI5D3iiazeQmCLghEA0N37CYn42W+aylbCvubNtB140vZeVW/vy9k01xYFJQAgGdeQGW5HzEaCHo/Rsj1E9H/jzLLGwTCdv2Ou4AQgJclY5hOWjQQjIfn6lU7bEpym8AQApm6iJzK/KqFQJBSkAAAtoWEaZsY8hSChYAUgQYslUz9kYLpLKFwBgGlItLj1W1ums4SCFgCgJ3QM3bDMN10lFLwAGOyKbMzlp6OEGSFAmpCM2durmW4SZoQAAEMz0DXrrgiml4QZIwBAi2VeJY9kukhw/O7o7de86HSVE0rLJa3c88DDhAcy35VtJCSndgxwaOlRR9+BN6MiIBcWL0q95aW0ZGre8nLOC4CpleAKGGSqJNgREB55EE9Oza7hZJCvhFg8MTpbeHTCaGy8tlIeH3l48GjIskghk4+Eg8fSThUCLE+WtQAh0h4bf/Xt94nEnH1r1HQjFwmffnmAHW+nf7UpJXusylu+CHrFqstPIMQtDMqKxOLs++IgVeVlVJWV4vFk+4eYCoOqygouvmA5H+z9D8lk5lW2pum8+9FedBRUz/DNYrqU8qaD+z7ozFTW1t3XP/7lhm1Icbutls8wtHiMjrYQpmG9yh716v5HX3nsgV9blrHTiKpY153AW3byzjSKfH5q5teiqPbfGp+IDOytinf+1k79tvqP/fv3m5evXPZS1BMoE3Ap59j0VfUU4Q8EiQ70Iy12XaWURPr7StvD4X+dbDnSZlV31g+A/OS2DctNwc8URJOEOsD6NuUZQjbdETb/utR0foJzWtK45upLJMpbQJWN7JYSzqmuxAk+3rPrv0LyA8DOTUIBaahzM2VwIyBHbESCJgXX79u9c0emelwBeZBBgq2TD66AvBlHgu2TD64ARxghoTSbk+/iII1N61avalq/fqrb4eLi4uLi4uLi4mKD/wNm0gfm007fHAAAAABJRU5ErkJggg==';

  static const imgMinisterio = rutaImg + "logoMinisterio.png";
  static const imgPaquito = rutaImg + "paquito.png";
  static const imgSello = rutaImg + "icondgi.png";



  static const imgPolice = rutaImg + "ic_police.png";
  static const imgInstalaciones = rutaImg + "ic_instalaciones.png";
  static const imgVehiculo = rutaImg + "ic_vehiculo.png";
  static const imgRuta = rutaImg + "ic_ruta.png";
  static const imgPie = rutaImg + "pie.png";


}