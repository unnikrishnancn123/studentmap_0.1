import 'package:meta/meta.dart';
import '../../../model/studentmodel.dart';

@immutable
abstract class FormStateSt {
  final Student student;
  final String message;

  const FormStateSt(this.student, this.message);
}

class InitialFormStateSt extends FormStateSt {
  InitialFormStateSt() : super(Student(),'');
}

class Loading extends FormStateSt {
  Loading() : super(Student(), '');
}

class Error extends FormStateSt {
  Error({required String errorMessage}) : super(Student(), errorMessage);
}

class Loaded extends FormStateSt {
  Loaded({Student? student}) : super(student ?? Student(), '');
}

class Success extends FormStateSt {
  Success({required String successMessage}) : super(Student(), successMessage);
}







