import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';
import 'package:sadeem/features/doctors/domain/usecases/add_doctor_usecase.dart';
import 'package:sadeem/features/doctors/domain/usecases/delete_doctor_isecase.dart';
import 'package:sadeem/features/doctors/domain/usecases/update_doctor_usecase.dart';

part 'add_new_doctors_event.dart';
part 'add_new_doctors_state.dart';

class AddNewDoctorsBloc extends Bloc<AddNewDoctorsEvent, AddNewDoctorsState> {
  final AddDoctorUsecase addDoctorUsecase;
  final UpdateDoctorUsecase updateDoctorUsecase;
  final DeleteDoctorUsecase deleteDoctorUsecase;
  AddNewDoctorsBloc({
    required this.addDoctorUsecase,
    required this.updateDoctorUsecase,
    required this.deleteDoctorUsecase,
  }) : super(AddNewDoctorsInitial()) {
    on<AddNewDoctorsEvent>((event, emit) async {
      if (event is AddDoctor) {
        emit(LoadingAddNewDoctorsState());
        final failureOrSuccess = await addDoctorUsecase.addDoctors(event.input);
        failureOrSuccess.fold((failure) {
          emit(ErrorAddNewDoctorsState(failure.toString()));
        }, (id) {
          emit(DoneAddNewDoctorsState(id));
        });
      } else if (event is UpdateDoctor) {
        emit(LoadingAddNewDoctorsState());
        final failureOrSuccess =
            await updateDoctorUsecase.updateDoctors(event.input, event.id);
        failureOrSuccess.fold((failure) {
          emit(ErrorAddNewDoctorsState(failure.toString()));
        }, (id) {
          emit(DoneAddNewDoctorsState(id));
        });
      } else if (event is DeleteDoctor) {
        emit(LoadingAddNewDoctorsState());
        final failureOrSuccess =
            await deleteDoctorUsecase.deleteDoctors(event.id);
        failureOrSuccess.fold((failure) {
          emit(ErrorAddNewDoctorsState(failure.toString()));
        }, (id) {
          emit(DoneAddNewDoctorsState(id));
        });
      }
    });
  }
}
