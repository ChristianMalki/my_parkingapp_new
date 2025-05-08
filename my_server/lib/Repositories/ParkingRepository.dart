import 'package:my_server/Repositories/FileRepository.dart';

import 'package:shared/shared.dart';

class ParkingRepository extends FileRepository<Parking> {
  ParkingRepository() : super('parkings.json');

  @override
  Parking fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return Parking.fromJson(json);
  }

  @override
  String idFromType(Parking parking) {
    // TODO: implement idFromType
    return parking.id;
  }

  @override
  Map<String, dynamic> toJson(Parking parking) {
    // TODO: implement toJson
    return parking.toJson();
  }
}
