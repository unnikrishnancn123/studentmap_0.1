
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../model/studentmodel.dart';

@immutable
abstract class ListState extends Equatable {
   late  final List<Student> students;
   late  final String message;


}

class InitialListState extends ListState {




  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class Loadingl extends ListState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Errors extends ListState {
  Errors({required String errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Loadedl extends ListState {
  Loadedl({required List<Student> students});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
