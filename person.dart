


abstract class Person {
  String? id = '';
  String? name;
  String? lastName;
  String? phone;
  String? gender;

  Person({this.id, required this.name, required this.lastName,this.phone,this.gender});

  String get getId => id!;
}
