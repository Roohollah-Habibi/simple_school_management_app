
import 'person.dart';

const lastIndexId = 500;
const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXZ';

class Teacher extends Person {
  static int _letterIndex = 0;
  static int _idCounter = 0;

  int salary;
  int _remainedSalary = 0;
  int _paid = 0;
  String? subject;

  Teacher(
      {required super.name,
      required super.lastName,
      required this.subject,
      this.salary = 0, super.phone , super.gender,
      }){
    id ?? _setId();
    _remainedSalary = salary;
  }

  int get getDisplaySalary => _remainedSalary;

  set setDisplaySalary(int value) {
    _remainedSalary = value;
  }

  void teacherPaid(int amount){
    if(amount <= _remainedSalary){
      _paid+= amount;
      _remainedSalary =_remainedSalary - amount;
        print('Successfuly paid $amount AF /total paid up to now [$_paid]AF\n remainderSalary: $_remainedSalary 😍💰');
    }else{
      print('payment more than teacher salary is impossible😢 plz check out teacher salary and payments before payment👀');
    }
  }
  void modifyTeacherProfile({String? name, String? lastName, String? phone, int? salary, String? subject, String? gender,}){
    this.name = name ?? this.name;
    this.lastName = lastName ?? this.lastName;
    this.gender = gender ?? this.gender;
    this.phone = phone ?? this.phone;
    this.salary = salary ?? this.salary;
    this.subject = subject ?? this.subject;

  }

  void displayInfo() {
    print('************************************************');
    print(
        'ID:$id\n'
        'Name: $name\n'
        'LastName: $lastName\n'
        'subject: $subject\n'
        'gender: $gender \n'
        'Phone: $phone\n'
        'Salary: $salary [AF]\n'
        'paid Salary: $_paid [AF]\n'
        'remained Salary: $_remainedSalary [AF]\n'
    );
    print('************************************************');

  }




  // set the teacher id automatically
  String _setId() {
    String letter = String.fromCharCode(letters.codeUnitAt(_letterIndex));
    _idCounter++;
    super.id = '$letter$_idCounter';
    if (_idCounter == lastIndexId) {
      _idCounter = 0;
      if (_letterIndex <= 'Z'.codeUnitAt(0)) {
        _letterIndex++;
      } else {
        _letterIndex = 0;
      }
    }
    return (super.getId != 'Z500')
        ? getId
        : '$letter${super.name.hashCode / 1000}${super.lastName.hashCode / 1000}';
  }
  @override
  int get hashCode {
    int prime = 19;
    prime = prime * 37 * name.hashCode;
    prime = prime * 23 * lastName.hashCode;
    return prime;
  }

  @override
  bool operator ==(Object object) {
    if (object is! Teacher) {
      return false;
    }
    return super.name == object.name &&
        super.lastName == object.lastName &&
        subject == object.subject;
  }
}
