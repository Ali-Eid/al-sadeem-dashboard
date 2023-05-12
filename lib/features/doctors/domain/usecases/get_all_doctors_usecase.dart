import 'package:dartz/dartz.dart';
import 'package:sadeem/core/error/failure_error.dart';
import 'package:sadeem/features/doctors/domain/entity/doctor_entity.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';

class GetAllDoctorsUsecase {
  final DoctorsRepository repository;

  GetAllDoctorsUsecase(this.repository);

  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    return await repository.getAllDoctors();
  }
}
