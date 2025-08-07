
part of 'censo_use_cases.dart';



class SaveCensusPersonPhotoUseCase {
  final CensoRepository repository;

  SaveCensusPersonPhotoUseCase({required this.repository});

  Future<bool> call({required UpdateFotoPerCensoRequest request }) {
    return repository.updateFoto(request: request);
  }
}

