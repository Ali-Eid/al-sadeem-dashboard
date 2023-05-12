import 'package:sadeem/features/doctors/data/datasource/local_data_source.dart';
import 'package:sadeem/core/error/failure_error.dart';
import 'package:dartz/dartz.dart';
import 'package:sadeem/features/doctors/domain/entity/doctor_entity.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';

class DoctorsRepositoryImpl implements DoctorsRepository {
  final LocalDataSource localDataSource;

  DoctorsRepositoryImpl(this.localDataSource);
  @override
  Future<Either<Failure, int>> addDoctor(DoctorInput input) async {
    try {
      var response = await localDataSource.insert(input);
      return right(response);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      var response = await localDataSource.read();
      return right(response);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> upadteDoctor(DoctorInput input, int id) async {
    try {
      var response = await localDataSource.update(input, id);
      return right(response);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteDoctor(int id) async {
    try {
      var response = await localDataSource.delete(id);
      return right(response);
    } catch (e) {
      return left(ServerFailure());
    }
  }
}
