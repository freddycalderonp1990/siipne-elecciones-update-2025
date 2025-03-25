import '../../data/models/models_user.dart';
import '../entities/user.dart';

class Mappers {
  static UserEntities fromDataUserToUserEntities(UserModel dataUser, {String token = ""}) {
    return UserEntities(
      idGenUsuario: dataUser.idGenUsuario,
      idGenPersona: dataUser.idGenPersona,
      nombreUsuario: dataUser.nombreUsuario,
      idDgpGrado: dataUser.idDgpGrado,
      documento: dataUser.documento,
      sexo: dataUser.apenom,
      nombres: dataUser.sexoPerson,
      gradoSiglas: dataUser.gradoSiglas,
      unidad: dataUser.unidad,
      funcion: dataUser.funcion,
      grado: dataUser.grado,
      foto: dataUser.foto,
      token: token,
    );
  }
}
