import 'package:dartz/dartz.dart';
import 'package:sadeem/core/error/failure_error.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';

class DeleteDoctorUsecase {
  final DoctorsRepository repository;

  DeleteDoctorUsecase(this.repository);

  Future<Either<Failure, int>> deleteDoctors(int id) async {
    return await repository.deleteDoctor(id);
  }
}
