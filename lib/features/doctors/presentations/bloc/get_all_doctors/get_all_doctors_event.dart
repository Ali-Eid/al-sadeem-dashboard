part of 'get_all_doctors_bloc.dart';

abstract class GetAllDoctorsEvent extends Equatable {
  const GetAllDoctorsEvent();

  @override
  List<Object> get props => [];
}

class GetAllDoctors extends GetAllDoctorsEvent {}
