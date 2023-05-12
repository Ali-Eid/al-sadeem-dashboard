part of 'add_new_doctors_bloc.dart';

abstract class AddNewDoctorsState extends Equatable {
  const AddNewDoctorsState();

  @override
  List<Object> get props => [];
}

class AddNewDoctorsInitial extends AddNewDoctorsState {}

class LoadingAddNewDoctorsState extends AddNewDoctorsState {}

class DoneAddNewDoctorsState extends AddNewDoctorsState {
  final int id;

  const DoneAddNewDoctorsState(this.id);
}

class ErrorAddNewDoctorsState extends AddNewDoctorsState {
  final String message;

  const ErrorAddNewDoctorsState(this.message);
}
