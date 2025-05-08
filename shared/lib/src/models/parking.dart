

class Parking {
  final String regnr;
  final String adress;
  final String id;

  Parking({required this.regnr, required this.adress, required this.id});

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      regnr: json['regnr'] as String,
      adress: json['adress'] as String,
      id: json['id'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'regnr': regnr,
      'adress': adress,
      'id': id,
    };
  }

 

  

}