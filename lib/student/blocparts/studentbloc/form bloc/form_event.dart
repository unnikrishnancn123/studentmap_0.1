import 'package:studentmap/student/model/studentmodel.dart';


abstract class FormEvent {
  final Student student;

  FormEvent(this.student);
}

class BackEvent extends FormEvent {
  BackEvent(Student student) : super(student);
}

class GetStudent extends FormEvent {
  GetStudent(Student student) : super(student);
}

class AddStudent extends FormEvent {
  AddStudent(Student student) : super(student);
}

class UpdateStudent extends FormEvent {
  UpdateStudent(Student student) : super(student);
}

