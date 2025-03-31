import 'package:my_parkingapp_new/models/parking.dart';

class ParkingRepository {
  List<Parking> parkeringar = [];

  ParkingRepository? get instance => null;

  void add(Parking parking) {
    parkeringar.add(parking);
  }

  Future<List<Parking>> getAll()async {
    return parkeringar;
  }


  void update(Parking updatedParking) {
    var index = parkeringar.indexWhere((parking) => parking.id == updatedParking.id);
    if (index != -1) {
      parkeringar[index] = updatedParking;
    }
  }

  void delete(String id) {
    parkeringar.removeWhere((parking) => parking.id == id);
  }

  void create(Parking parking) {
    parkeringar.add(parking);
  }
}




 
