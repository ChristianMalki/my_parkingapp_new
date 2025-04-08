class Vehicle {
  final String regNr;
  final String id;
  final String model;

  Vehicle({required this.regNr, required this.id, required this.model});

  get registreringsnummer => null;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      regNr: json['regNr'] as String,
      id: json['id'] as String,
      model: json['model'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'regNr': regNr,
      'id': id,
      'model': model,
    };
  }
}
