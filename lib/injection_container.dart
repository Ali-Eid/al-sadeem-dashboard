import 'package:get_it/get_it.dart';
import 'package:sadeem/core/DB/sql_db.dart';
import 'package:sadeem/features/doctors/data/datasource/local_data_source.dart';
import 'package:sadeem/features/doctors/data/repository/doctor_repository_impl.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';
import 'package:sadeem/features/doctors/domain/usecases/add_doctor_usecase.dart';
import 'package:sadeem/features/doctors/domain/usecases/delete_doctor_isecase.dart';
import 'package:sadeem/features/doctors/domain/usecases/get_all_doctors_usecase.dart';
import 'package:sadeem/features/doctors/domain/usecases/update_doctor_usecase.dart';
import 'package:sadeem/features/doctors/presentations/bloc/add_new_doctor/add_new_doctors_bloc.dart';
import 'package:sadeem/features/doctors/presentations/bloc/get_all_doctors/get_all_doctors_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
//Bloc
  sl.registerFactory(() => GetAllDoctorsBloc(getAllDoctorsUsecase: sl()));
  sl.registerFactory(() => AddNewDoctorsBloc(
      addDoctorUsecase: sl(),
      updateDoctorUsecase: sl(),
      deleteDoctorUsecase: sl()));

//usecase

  sl.registerLazySingleton(() => AddDoctorUsecase(sl()));
  sl.registerLazySingleton(() => GetAllDoctorsUsecase(sl()));
  sl.registerLazySingleton(() => UpdateDoctorUsecase(sl()));
  sl.registerLazySingleton(() => DeleteDoctorUsecase(sl()));

  //repository

  sl.registerLazySingleton<DoctorsRepository>(
      () => DoctorsRepositoryImpl(sl()));

  //Datasource
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sl()));

  //External
  sl.registerLazySingleton(() => SqlDB());
}
