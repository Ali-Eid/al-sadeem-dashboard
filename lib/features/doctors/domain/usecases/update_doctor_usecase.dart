import 'package:dartz/dartz.dart';
import 'package:sadeem/core/error/failure_error.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';

class UpdateDoctorUsecase {
  final DoctorsRepository repository;

  UpdateDoctorUsecase(this.repository);

  Future<Either<Failure, int>> updateDoctors(DoctorInput input, int id) async {
    return await repository.upadteDoctor(input, id);
  }
}
