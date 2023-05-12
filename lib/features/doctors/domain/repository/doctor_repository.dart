import 'package:dartz/dartz.dart';
import 'package:sadeem/core/error/failure_error.dart';
import 'package:sadeem/features/doctors/domain/entity/doctor_entity.dart';

abstract class DoctorsRepository {
  Future<Either<Failure, int>> addDoctor(DoctorInput input);
  Future<Either<Failure, int>> upadteDoctor(DoctorInput input, int id);
  Future<Either<Failure, int>> deleteDoctor(int id);
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors();
}

class DoctorInput {
  final String name;
  final String specialist;
  // final String image;
  final String phone;
  final String email;

  DoctorInput(this.name, this.specialist, this.phone, this.email);
}
