
import 'package:meta/meta.dart';

import '../../../model/studentmodel.dart';

@immutable
abstract class ListEvent {
  final Student student;
  final String query;

  const ListEvent(this.student, this.query);
}

class GetStudents extends ListEvent {
  GetStudents({String? query}) : super(Student(name: '', address: '', email: '', district: '', dob: '', data: '', gender: '', phone: '', crtloc: ''), query!);
}

class DeleteUser extends ListEvent {
  DeleteUser({ Student ?student}) : super(student!, '');
}
