
part of 'censo_use_cases.dart';



class SaveFoto {
  final CensoRepository repository;

  SaveFoto({required this.repository});

  Future<bool> call({required UpdateFotoPerCensoRequest request }) {
    return repository.updateFoto(request: request);
  }
}

