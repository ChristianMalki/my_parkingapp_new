class Person {
  final String name;
  final String personnummer;
  final String id;

  Person({required this.name, required this.personnummer, required this.id});
 
  

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
      personnummer: json['personnummer'] as String,
      id: json['id'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'personnummer': personnummer,
      'id': id,
    };
  }
 

  


}
