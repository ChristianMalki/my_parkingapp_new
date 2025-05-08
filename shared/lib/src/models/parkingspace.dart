// ignore: file_names
import 'package:shared/src/models/parkingspace.dart';

class ParkingSpace {
  final String id;
  final String adress;
  

  ParkingSpace({required this.id, required this.adress});

  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      id: json['id'] as String,
      adress: json['adress'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adress': adress,
    };
  }

 

}