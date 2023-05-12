import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadeem/features/doctors/domain/entity/doctor_entity.dart';
import 'package:sadeem/features/doctors/domain/usecases/get_all_doctors_usecase.dart';

part 'get_all_doctors_event.dart';
part 'get_all_doctors_state.dart';

class GetAllDoctorsBloc extends Bloc<GetAllDoctorsEvent, GetAllDoctorsState> {
  final GetAllDoctorsUsecase getAllDoctorsUsecase;
  GetAllDoctorsBloc({required this.getAllDoctorsUsecase})
      : super(GetAllDoctorsInitial()) {
    on<GetAllDoctorsEvent>((event, emit) async {
      if (event is GetAllDoctors) {
        emit(LoadingGetAllDoctors());
        final failureOrDoctors = await getAllDoctorsUsecase.getAllDoctors();
        failureOrDoctors.fold((failure) {
          emit(ErrorGetAllDoctors(failure.toString()));
        }, (doctors) {
          emit(DoneGetAllDoctors(doctors));
        });
      }
    });
  }
}
