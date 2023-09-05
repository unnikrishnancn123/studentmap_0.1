/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:studentmap/student/blocparts/studentbloc/listbloc/bloc.dart';
import '../blocparts/studentbloc/form bloc/bloc.dart';
import '../blocparts/studentbloc/form bloc/form_bloc.dart';
import '../blocparts/studentbloc/form bloc/form_bloc.dart';
import '../blocparts/studentbloc/listbloc/list_bloc.dart';
import '../model/studentmodel.dart';
import 'Homescreen.dart';


class studentListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  late ListBloc listBloc;
   late FormBloc formBloc;

  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    listBloc = BlocProvider.of<ListBloc>(context);
    formBloc = BlocProvider.of<FormBloc>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            autocorrect: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {

 listBloc.add(GetStudents(query: _searchController.text));

                },
              ),
              hintText: 'Search...',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<HomeScreen>(
                  builder: (context) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<FormBloc>.value(
                          value: BlocProvider.of<FormBloc>(context),
                        ),
                        BlocProvider<ListBloc>.value(
                          value: listBloc,
                        ),
                      ],
                      child: HomeScreen(),
                    );
                  },
                ),
              );
            }),
        body: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
         listBloc.add(GetStudents());
    },


            child: BlocListener<FormBloc,FormStateSt>(
              listenWhen: (previousState, state) {
                return null!;
              },
              listener: (context, state) {

                if (state.message.isNotEmpty) {
                  _scaffoldKey.currentState?.showBottomSheet((context) => Container(
                    // Replace the Container with your desired widget that displays the message
                    child: Text(state.message),
                  ));
                }
              },
              child: BlocBuilder<ListBloc, ListState>(
                  builder: (context, state) {
                    if (state is Loaded) {
                      return Container(
                          child: (state.students.isNotEmpty
                              ? ListView.builder(
                            itemCount: state.students.length,
                            itemBuilder: (context, index) {
                              Student student = state.students[index];
                              return _userCard(student, context);
                            },
                          )
                              : NoData()));
                    }
                    if (state is Error) {
                      return error(state.message);
                    }
                    return loading();
                  }),
            ),
          ),
        ));
  }

  Card _userCard(Student student, BuildContext context) {
    return Card(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(padding: EdgeInsets.all(10), child: Text(student.name!)),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute<HomeScreen>(
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider<FormBloc>.value(
                                    value: formBloc.add(FormBloc(student: student) as FormEvent),
                                  ),
                                  BlocProvider<ListBloc>.value(
                                    value: listBloc,
                                  ),
                                ],
                                child: HomeScreen(),
                              );
                            },
                          );

                      },
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      listBloc.add(DeleteUser(student: student));
                      (SnackBar(content: Text(student.name! + ' deleted')));
                    },

                  )
                ],
              ),
            ],
          ),
        ));
  }*/
