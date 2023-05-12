import 'package:sadeem/core/DB/sql_db.dart';
import 'package:sadeem/features/doctors/data/model/add_doctors_model.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';

abstract class LocalDataSource {
  Future<int> insert(DoctorInput input);
  Future<int> update(DoctorInput input, int id);
  Future<int> delete(int id);
  Future<List<DoctorModel>> read();
  // Future<int> insert(DoctorInput input);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SqlDB sqlDB;

  LocalDataSourceImpl(this.sqlDB);
  @override
  Future<int> insert(DoctorInput input) async {
    int response = await sqlDB.insertData(
        'INSERT INTO doctors(name, specialist, phone,email) VALUES("${input.name}", "${input.specialist}","${input.phone}","${input.email}")');
    return response;
  }

  @override
  Future<int> update(DoctorInput input, int id) async {
    int response = await sqlDB.updateData(
      'UPDATE doctors SET name = ?, specialist = ?, phone = ?, email = ? WHERE id = ?',
      [(input.name), (input.specialist), (input.phone), (input.email), id],
    );
    return response;
  }

  @override
  Future<List<DoctorModel>> read() async {
    List<Map<String, dynamic>> response =
        await sqlDB.readData('SELECT * FROM doctors');
    List<DoctorModel> models = response.map((e) {
      return DoctorModel.fromjson(e);
    }).toList();
    return models;
  }

  @override
  Future<int> delete(int id) async {
    int response = await sqlDB.updateData(
      'DELETE FROM doctors WHERE id = ?',
      [id],
    );
    return response;
  }
}
