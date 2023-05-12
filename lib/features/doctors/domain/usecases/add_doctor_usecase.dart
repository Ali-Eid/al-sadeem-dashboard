import 'package:dartz/dartz.dart';
import 'package:sadeem/core/error/failure_error.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';

class AddDoctorUsecase {
  final DoctorsRepository repository;

  AddDoctorUsecase(this.repository);

  Future<Either<Failure, int>> addDoctors(DoctorInput input) async {
    return await repository.addDoctor(input);
  }
}
