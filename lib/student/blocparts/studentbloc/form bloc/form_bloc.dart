import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../model/studentmodel.dart';
import '../../../repository/repository.dart';
import './bloc.dart';



class FormBloc extends Bloc<FormEvent,FormStateSt> {
  FormBloc() : super(InitialFormStateSt());
  final _studentRepository = StudentRepository ();

  Stream<FormStateSt> mapEventToState(FormEvent event) async* {
    yield Loading();
    if (event is GetStudent) {
      try {
        yield Loaded(
            student: event.student.id == null
                ? Student()
                : await _studentRepository.getStudentById(event.student.id));
      } catch (e) {
        yield Error(errorMessage: e.toString());
      }
    } else if (event is BackEvent) {
      yield InitialFormStateSt();
    } else if  (event is AddStudent) {
      try {
        await _studentRepository.addStudent(event.student);
        yield Success(successMessage: event.student.name! + ' created');
      } catch (e) {
        yield Error(errorMessage: e.toString());
      }
    } else if (event is UpdateStudent) {
      try {
        await _studentRepository.updateStudent(event.student);
        yield Success(successMessage: event.student.name! + ' updated');
      } catch (e) {
        yield Error(errorMessage: e.toString());
      }
    }
  }

  @override
  FormStateSt get state => super.state;

  @override
  Future<void> close() {
    // Clean up resources
    return super.close();
  }
}