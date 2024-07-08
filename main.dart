import 'dart:io';
import 'constants.dart';
import 'admin.dart';
import 'teacher.dart';

void main() {
  Admin admin = Admin(
      name: 'Hamed',
      lastName: 'Homayoon',
      id: 'admin',
      password: 'a',
      // initial password
      phone: '0792253070',
      gender: 'Male');
  bool startApp = true;

  while (startApp) {
    print(loginPageMSG);

    print(loginPages);

    stdout.write('Select: ');
    String userNameInput = stdin.readLineSync().toString().toLowerCase();
    switch (userNameInput) {
      case 'a' || 'admin':
        stdout.write('password:');
        String passwordInput = stdin.readLineSync().toString().toLowerCase();
        if (passwordInput == admin.getPassword as String) {
          admin.openAdminPanel = true;
          print(adminPanelMSG);
          adminPanelMethod(admin);
        } else {
          continue;
        }
      case 'q' || 'quit':
        print('have a Good Day 😁👍');
        startApp = false;
      case 'm' || 'moderator':
        print(msg);
      default:
        print('Invalid input try again✌');
    }
  }
}

void adminPanelMethod(Admin admin) {
  while (admin.openAdminPanel) {
    admin.displayInstructions;
    stdout.write('Select: ');
    String userAnswer = stdin.readLineSync().toString().toLowerCase();
    switch (userAnswer) {
      case 'mt':
        modifyTeacherMethod(admin);
      case 'ht':
        addTeacherMethod(admin);
      case 'vt':
        admin.displayTeachers;
      case 'c':
        changeAdminPassword(admin);
      case 'ft':
        removeTeacherMethod(admin);
      case 'p':
        admin.adminProfile;
      case 'pt':
        payTeacherSalaryMethod(admin);
      case 'q':
        admin.openAdminPanel = false;
      default:
        print('Invalid input 👀');
    }
  }
}

void modifyTeacherMethod(Admin admin) {
  String? name, lastName, gender, phone, subject, userInput;
  int? salary;
  bool goForward = true;

  print(
      '\t\t\t\t\t\t ====================> Edit profile instructions <==================== \n');

  stdout.write(
      'type teacher Id correctly.or type [vt] from main menu to find out teacher\'s id from teachers list: ');
  userInput = stdin.readLineSync().toString();

  Teacher foundTeacher;
  if (admin.teacherList.any((element) => element.id == userInput)) {
    foundTeacher = admin.teacherList
        .firstWhere((existTeacher) => existTeacher.id == userInput);
  } else {
    print('id [$userInput] is not recognized as a valid id ❌ ');
    return;
  }
  print(
      '${foundTeacher.name} ${foundTeacher.lastName} is ready to be modified');
  print(editPartSectionInstructions);
  while (goForward) {
    stdout.write('Select: ');
    String answer = stdin.readLineSync().toString().toLowerCase();
    switch (answer) {
      case 'n' || 'name':
        stdout.write('New name: ');
        name = stdin.readLineSync().toString();
        foundTeacher.modifyTeacherProfile(name: name);
      case 'l' || 'last':
        stdout.write('New last name: ');
        lastName = stdin.readLineSync().toString();
        foundTeacher.modifyTeacherProfile(lastName: lastName);
      case 'g' || 'gender':
        stdout.write('New gender: ');
        gender = stdin.readLineSync().toString();
        foundTeacher.modifyTeacherProfile(gender: gender);
      case 'p' || 'phone':
        stdout.write('New phone: ');
        phone = stdin.readLineSync().toString();
        foundTeacher.modifyTeacherProfile(phone: phone);
      case 's' || 'subject':
        stdout.write('New subject: ');
        subject = stdin.readLineSync().toString();
        foundTeacher.modifyTeacherProfile(subject: subject);
      case 'sl' || 'salary':
        stdout.write('New salary: ');
        salary = int.parse(stdin.readLineSync().toString());
        foundTeacher.modifyTeacherProfile(salary: salary);
      case 'e' || 'exit':
        goForward = false;
    }
  }
}

void payTeacherSalaryMethod(Admin admin) {
  String? name, lastName, subject,teacherId;
  int amount = 0;
  stdout.write('Teacher name: ');
  name = stdin.readLineSync().toString();

  stdout.write('last name: ');
  lastName = stdin.readLineSync().toString();

  stdout.write('field/subject: ');
  subject = stdin.readLineSync().toString();

  stdout.write('amount to pay: ');
  String input = stdin.readLineSync().toString();

  if(input.contains(RegExp(r'^[0-9]+$'))){
    amount = int.parse(input);
    Teacher teacher = Teacher(name: name, lastName: lastName, subject: subject);
    admin.teacherPayment(teacher, amount);
  }else{
    print('invalid amount❌');
  }
}

void changeAdminPassword(Admin admin) {
  stdout.write('Previous Password: ');
  String userAns = stdin.readLineSync().toString().toLowerCase();
  bool goForward = userAns == admin.getPassword as String;
  if (goForward) {
    stdout.write('New Password: ');
    String newPassword = stdin.readLineSync().toString().toLowerCase();
    admin.setPassword(currentPassword: userAns, newPassword: newPassword);
  } else {
    print('Invalid Password try again or press the forgot password🔒\n');
  }
}

void addTeacherMethod(Admin admin) {
  print('\n\t [*]=> means should not be Empty');
  String? name, lastName, gender, phone, subject;
  int salary = 0;
  List<Teacher> myTeacher = admin.teacherList;
  bool go = true;
  while (go) {
    stdout.write('Teacher name[*]: ');
    name = stdin.readLineSync().toString();

    stdout.write('last name[*]: ');
    lastName = stdin.readLineSync().toString();

    stdout.write('subject[*]: ');
    subject = stdin.readLineSync().toString();
    if (name.isEmpty || lastName.isEmpty || subject.isEmpty) {
      print('name/last name and subject could not be empty');
      continue;
    }
    bool goForward = myTeacher.any((element) =>
        (element.name == name) &&
        (element.lastName == lastName) &&
        (element.subject == subject));
    if (goForward) {
      print(
          '$name $lastName is already hired and teaching $subject [pay attention in hiring teachers]');
      continue;
    } else {
      go = false;
    }
    stdout.write('[Optional]Gender:');
    gender = stdin.readLineSync().toString().toLowerCase();

    stdout.write('[Optional]phone:');
    phone = stdin.readLineSync().toString().toLowerCase();

    stdout.write('[Optional]Salary: ');
    String userInput = stdin.readLineSync().toString();

    if (RegExp(r'^-?[0-9]+$').hasMatch(userInput)) {
      salary = int.parse(userInput);
    } else {
      if (userInput.isEmpty) {
        print('\t ==> default value [0.00] is automatically set for an empty salary 😉 <==');
      } else {
        print('\t ==> salary option can\'t contains letters or spaces ❌ <==\n'
            '\t ==> so default salary[0.00] is set automatically <==\n');
      }
    }
    admin.addTeacher(Teacher(
        name: name,
        lastName: lastName,
        subject: subject,
        gender: (gender.isEmpty)? 'not set': gender,
        phone: (phone.isEmpty)? 'not set': phone,
        salary: salary));
  }
}

void removeTeacherMethod(Admin admin) {
  print('1- [Id]to remove by ID\n'
      '2- [d] to remove by identity');
  stdout.write('Select: ');
  String answer = stdin.readLineSync().toString().toLowerCase();
  switch (answer) {
    case 'id':
      stdout.write('ID:');
      String teacherId = stdin.readLineSync().toString();
      admin.removeTeacherById(teacherId);
    case 'd':
      stdout.write('Name:');
      String teacherName = stdin.readLineSync().toString();
      stdout.write('L/Name:');
      String teacherLastName = stdin.readLineSync().toString();
      stdout.write('Field:');
      String teacherField = stdin.readLineSync().toString();
      admin.removeTeacher(Teacher(
        name: teacherName,
        lastName: teacherLastName,
        subject: teacherField,
      ));
  }
}
