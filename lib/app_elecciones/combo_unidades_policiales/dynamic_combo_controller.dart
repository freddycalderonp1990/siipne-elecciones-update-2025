import 'package:get/get.dart';

import '../../app/core/exceptions/exception_dialogos.dart';
import '../../app/presentation/widgets/custom_app_widgets.dart';
import '../data/models/models.dart';
import '../data/repository/data_repositories.dart';
import '../presentation/modules/controllers.dart';

class DynamicComboController extends GetxController {
  RxList<List<UnidadesPoliciale>> niveles = <List<UnidadesPoliciale>>[].obs;
  RxList<UnidadesPoliciale> seleccionados = <UnidadesPoliciale>[].obs;
  final EleccionesTipoEjesApiImpl _eleccionesTipoEjesApiImpl =
      Get.find<EleccionesTipoEjesApiImpl>();
  RxBool showBtnGuardar = false.obs;

  int idDgoTipoEje = 0;

  late int idGenUsuario;

  // 🔹 Referencia externa opcional (para compartir estado de carga)
  RxBool peticionServerStateExterna = false.obs;

  /// Inicializa el primer nivel
  Future<void> init({required int idGenUsuario, int idDgoTipoEje = 0}) async {
    this.idGenUsuario = idGenUsuario;

    var data;
    if (idDgoTipoEje == 0) {
      data = await getSubsistemas(idGenUsuario: idGenUsuario);
    } else {
      data = await getTipoEjesPoridDgoTipoEje(
        idDgoTipoEje: idDgoTipoEje,
        idGenUsuario: idGenUsuario,
        descripcion: "No existen Datos",
      );
    }
    niveles.assign(data);
    seleccionados.assign(UnidadesPoliciale.empty());
    showBtnGuardar.value = false;
  }

  /// Cargar siguiente nivel
  Future<void> cargarSiguienteNivel(
    UnidadesPoliciale seleccionado,
    int index,
  ) async {
    showBtnGuardar.value = false;

    if (niveles.length > index + 1) {
      niveles.removeRange(index + 1, niveles.length);
      seleccionados.removeRange(index + 1, seleccionados.length);
    }

    if (seleccionado.tieneHijos) {
      final hijos = await getTipoEjesPoridDgoTipoEje(
        idDgoTipoEje: seleccionado.idDgoTipoEje,
        idGenUsuario: idGenUsuario,
        descripcion: "No existen ${seleccionado.descripcion}",
      );

      if (hijos.isNotEmpty) {
        niveles.add(hijos);
        seleccionados.add(UnidadesPoliciale.empty());
      }
    } else {
      showBtnGuardar.value = true;
    }
  }

  /// Reiniciar desde un nivel
  void reiniciarDesdeNivel(int index) {
    if (index < 0 || index >= niveles.length) return;
    if (niveles.length > index + 1) {
      niveles.removeRange(index + 1, niveles.length);
      seleccionados.removeRange(index + 1, seleccionados.length);
    }
    seleccionados[index] = UnidadesPoliciale.empty();
    showBtnGuardar.value = false;
  }

  /// Obtener el último ítem seleccionado válido
  UnidadesPoliciale get ultimoSeleccionado {
    return seleccionados.lastWhere(
      (e) => e.idDgoTipoEje > 0,
      orElse: () => UnidadesPoliciale.empty(),
    );
  }

  Future<List<UnidadesPoliciale>> getSubsistemas({
    required int idGenUsuario,
  }) async {
    print("consultando getSubsistemas");

    List<UnidadesPoliciale> resultado = [];
    peticionServerStateExterna(true);
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      resultado = await _eleccionesTipoEjesApiImpl.getUnidadesPoliciales(
        usuario: idGenUsuario,
      );

      peticionServerStateExterna(false);
      if (resultado.isEmpty) {
        DialogosAwesome.getInformation(
          descripcion: "No existen Unidades Policiales",
        );
      }
    });

    return resultado;
  }

  Future<List<UnidadesPoliciale>> getTipoEjesPoridDgoTipoEje({
    required int idDgoTipoEje,
    required int idGenUsuario,
    required String descripcion,
  }) async {
    peticionServerStateExterna(true);

    List<UnidadesPoliciale> list = [];
    bool result = await ExceptionDialogos.manejarErroresShowDialogo(() async {
      list = await _eleccionesTipoEjesApiImpl.getTipoEjePorIdPadre(
        usuario: idGenUsuario,
        idDgoTipoEje: idDgoTipoEje,
      );
    });

    peticionServerStateExterna(false);

    if (result && list.length == 0) {
      DialogosAwesome.getInformation(
        title: "Sin Datos",
        descripcion: descripcion,
      );
    }
    return list;
  }
}
