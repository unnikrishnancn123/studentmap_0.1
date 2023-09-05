import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../model/studentmodel.dart';
import '../../../repository/repository.dart';
import 'list_event.dart';
import 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final _studentRepository = StudentRepository();

  ListBloc() : super(InitialListState());

  Stream<ListState> mapEventToState(ListEvent event) async* {
    yield Loadingl();

    if (event is GetStudents) {
      try {
        List<Student> students = await _studentRepository.getStudents(query: event.query);
        yield Loadedl(students: students);
      } catch (e) {
        yield Errors(errorMessage: e.toString());
      }
    } else if (event is DeleteUser) {
      try {
        await _studentRepository.deleteStudent(event.student.id!);
        yield Loadedl(students: await _studentRepository.getStudents(query: event.query));
      } catch (e) {
        yield Errors(errorMessage: e.toString());
      }
    }
  }
}
