part of 'add_new_doctors_bloc.dart';

abstract class AddNewDoctorsEvent extends Equatable {
  const AddNewDoctorsEvent();

  @override
  List<Object> get props => [];
}

class AddDoctor extends AddNewDoctorsEvent {
  final DoctorInput input;

  const AddDoctor(this.input);

  @override
  List<Object> get props => [input];
}

class UpdateDoctor extends AddNewDoctorsEvent {
  final DoctorInput input;
  final int id;

  const UpdateDoctor(this.input, this.id);

  @override
  List<Object> get props => [input, id];
}

class DeleteDoctor extends AddNewDoctorsEvent {
  final int id;
  const DeleteDoctor(this.id);

  @override
  List<Object> get props => [id];
}
