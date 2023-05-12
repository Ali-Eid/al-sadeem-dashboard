part of 'get_all_doctors_bloc.dart';

abstract class GetAllDoctorsState extends Equatable {
  const GetAllDoctorsState();

  @override
  List<Object> get props => [];
}

class GetAllDoctorsInitial extends GetAllDoctorsState {}

class LoadingGetAllDoctors extends GetAllDoctorsState {}

class DoneGetAllDoctors extends GetAllDoctorsState {
  final List<DoctorEntity> doctors;

  const DoneGetAllDoctors(this.doctors);
}

class ErrorGetAllDoctors extends GetAllDoctorsState {
  final String message;

  const ErrorGetAllDoctors(this.message);
}
