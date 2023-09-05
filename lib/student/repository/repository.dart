import 'package:studentmap/student/service/helper.dart';
import '../model/studentmodel.dart';

class StudentRepository {
  late Helper helper ;

  Future getStudents({query}) => helper.getStudents();

  Future getStudentById(int? id) =>helper.getStudent(id!);

  Future  addStudent(Student student) =>helper.addStudent(student);

  Future updateStudent(Student student) => helper.updateStudent(student);

  Future deleteStudent(int id) => helper.deleteStudent(id);
}