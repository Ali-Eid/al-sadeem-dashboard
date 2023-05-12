import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  @override
  final int id;
  final String name;
  final String specialist;
  final String phone;
  final String email;
  // final String image;

  const DoctorEntity(
    this.id,
    this.name,
    this.specialist,
    this.phone,
    this.email,
  );
  @override
  List<Object?> get props => [
        id,
        name,
        specialist,
        phone,
        email,
      ];
}
