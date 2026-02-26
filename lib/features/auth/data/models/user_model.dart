import 'package:sowlab_app/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String email;
  final String fullName;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      role: json['role'] ?? 'user',
    );
  }

  // Mapper: DTO -> Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id.toString(),
      email: email,
      fullName: fullName,
      role: role,
    );
  }
}
