import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String password;
  final String roleId;
  final String status;
  final String? createdAt;
  final String? updatedAt;
  final String thumbnail;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.password,
    required this.roleId,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.thumbnail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      roleId: json['role_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role_id': roleId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'thumbnail': thumbnail,
    };
  }
}
