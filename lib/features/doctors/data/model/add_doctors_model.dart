import 'package:sadeem/features/doctors/domain/entity/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  const DoctorModel(
    super.id,
    super.name,
    super.specialist,
    super.phone,
    super.email,
  );
  factory DoctorModel.fromjson(Map<String, dynamic> json) {
    return DoctorModel(
      json['id'],
      json['name'],
      json['specialist'],
      json['phone'],
      json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialist': specialist,
      'phone': phone,
      'email': email,
      // 'image': image
    };
  }
}
