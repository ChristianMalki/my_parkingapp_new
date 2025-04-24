import 'package:my_server/Repositories/FileRepository.dart';

import 'package:shared/shared.dart';

class ParkingSpaceRepository extends FileRepository<ParkingSpace> {
  ParkingSpaceRepository() : super('items.json');

  @override
  ParkingSpace fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return ParkingSpace.fromJson(json);
  }

  @override
  String idFromType(ParkingSpace parkingspace) {
    // TODO: implement idFromType
    return parkingspace.id;
  }

  @override
  Map<String, dynamic> toJson(ParkingSpace parkingspace) {
    // TODO: implement toJson
    return parkingspace.toJson();
  }
}






