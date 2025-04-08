import 'package:shared/shared.dart';

class ParkingRepository {
  List<Parking> parkeringar = [];

  ParkingRepository? get instance => null;

  Future add(Parking parking) async {
    parkeringar.add(parking);
  }

  Future<List<Parking>> getAll() async {
    return parkeringar;
  }

  Future update(Parking updatedParking) async {
    var index =
        parkeringar.indexWhere((parking) => parking.id == updatedParking.id);
    if (index != -1) {
      parkeringar[index] = updatedParking;
    }
  }

  Future delete(String id) async {
    var index = parkeringar.indexWhere((parking) => parking.id == id);
    if (index != -1) {
      parkeringar.removeAt(index);
    } else {
      throw RangeError.index(index, parkeringar);
    }
  }

  Future create(Parking parking) async {
    parkeringar.add(parking);
  }
}
