import 'person.dart';
import 'teacher.dart';

class Admin extends Person {
  List<Teacher> teacherList = [];
  List<String> subjects = [];
  String? password = 'admin';
  bool _openAdminPanel = false;

  Admin(
      {this.password,
      required super.name,
      required super.lastName,
      super.id,
      required super.phone,
      required super.gender});

  get getPassword => password;

  bool get openAdminPanel => _openAdminPanel;

  set openAdminPanel(bool openPanel) => _openAdminPanel = openPanel;

  void modifyTeacherProfile(Teacher teacher,{String? name, String? lastName, String? phone, int? salary, String? subject, String? gender,}){
    Teacher foundTeacher = teacherList.firstWhere((element) => element.id == teacher.id);
    if(teacherList.contains(foundTeacher)){
      foundTeacher.modifyTeacherProfile(name: name,lastName: lastName,phone: phone,salary: salary,subject: subject,gender: gender);
    }else{
      print('${foundTeacher.name} ${foundTeacher.lastName} is not found 😢');
    }

  }

  void teacherPayment(Teacher teacher, int amount){
    bool foundTeacher = teacherList.any((existTeacher) => existTeacher == teacher);
    if(foundTeacher){
      Teacher myTeacher = teacherList.firstWhere((element) => element == teacher);
      myTeacher.teacherPaid(amount);
    }else{
      print('${teacher.name} ${teacher.lastName} could not be found to be paid 🤷‍♀️\n');
    }
  }

  void setPassword(
      {required String currentPassword, required String newPassword}) {
    bool goForward = currentPassword == (getPassword as String);
    if (goForward) {
      if (newPassword.length >= 8 &&
          newPassword.contains(RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'))) {
        print('password has been changed successfully😉✔\n');
        password = newPassword;
      } else {
        print('password must be at least 8 character contains both uppercase and lowercase alphabet⚠\n');
      }
    }
  }

  void addTeacher(Teacher teacher) {
    if (teacherList.any((element) => element == teacher)) {
      print('${teacher.name} is already exist');
      return;
    }
    teacherList.add(teacher);
    print('${teacher.name} ${teacher.lastName} is hired successfully ✔✔\n');
  }

  void removeTeacher(Teacher teacher) {
    if (teacherList.any((existTeacher) => existTeacher == teacher)) {
      teacherList.remove(teacher);
      print(
          '${teacher.name} ${teacher.lastName} who teaches ${teacher.subject} is fired successfully 🔥');
    } else {
      print(
          '${teacher.name} ${teacher.lastName} who teaches ${teacher.subject} is not found in database as teacher 😒🤦‍♂️');
    }
  }

  void removeTeacherById(String teacherId) {
    bool foundTeacher = teacherList.any((existTeacher) => existTeacher.id == teacherId);
    if (foundTeacher) {
      String? tName,lName;
      teacherList.removeWhere((existTeacher){
        tName = existTeacher.name;
        lName = existTeacher.lastName;
        return existTeacher.id == teacherId;
      });
      print(
          '$tName $lName with ID:[$teacherId] is fired successfully. 🔥');
    } else {
      print('such Id [$teacherId] dose not exist in database 😒👀');
    }
  }

  void get displayInstructions {
    print('\t\tInstructions');
    print('1- [ht] to hire teacher 🙋‍♂️\n'
        '2- [ft] to fire teacher 🔥\n'
        '3- [c] to change password 🔑\n'
        '4- [vt] to view teachers list 📃\n'
        '5- [p] to view your profile 👨‍🏫\n'
        '6- [i] to view instructions 👀\n'
        '7- [pt] to pay teachers 💰\n'
        '7- [mt] to modify teacher profile ✍\n'
        '0- [q] to exit ⏲');
  }

  void get adminProfile {
    print('========================= Admin profile =========================');
    print('name: $name \n'
        'name: $lastName'
        'Phone: $phone\n'
        'number of Teacher working with: ${teacherList.length}\n'
        ' gender: $gender\n'
        'bio: I love Administration😍\n');
  }

  void get displayTeachers {
    print('\t\t\t\ Teachers List\n');
    if(teacherList.isEmpty){
      print('\t\tNO teacher is hired yet 🤞\n');
    }else{
      for (Teacher teacher in teacherList) {
        teacher.displayInfo();
      }
    }
  }
}
