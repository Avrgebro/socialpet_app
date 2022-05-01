import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String f_lastname;
  final String m_lastname;
  final String email;
  final String firebase_uuid;
  final String phone;
  final String country;
  final DateTime birthday;
  User({
    required this.name,
    required this.f_lastname,
    required this.m_lastname,
    required this.email,
    required this.firebase_uuid,
    required this.phone,
    required this.country,
    required this.birthday,
  });


  User copyWith({
    String? name,
    String? f_lastname,
    String? m_lastname,
    String? email,
    String? firebase_uuid,
    String? phone,
    String? country,
    DateTime? birthday,
  }) {
    return User(
      name: name ?? this.name,
      f_lastname: f_lastname ?? this.f_lastname,
      m_lastname: m_lastname ?? this.m_lastname,
      email: email ?? this.email,
      firebase_uuid: firebase_uuid ?? this.firebase_uuid,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'f_lastname': f_lastname,
      'm_lastname': m_lastname,
      'email': email,
      'firebase_uuid': firebase_uuid,
      'phone': phone,
      'country': country,
      'birthday': birthday,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      f_lastname: map['f_lastname'] ?? '',
      m_lastname: map['m_lastname'] ?? '',
      email: map['email'] ?? '',
      firebase_uuid: map['firebase_uuid'] ?? '',
      phone: map['phone'] ?? '',
      country: map['country'] ?? '',
      birthday: DateTime.parse(map['birthday'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, f_lastname: $f_lastname, m_lastname: $m_lastname, email: $email, firebase_uuid: $firebase_uuid, phone: $phone, country: $country, birthday: $birthday)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.f_lastname == f_lastname &&
      other.m_lastname == m_lastname &&
      other.email == email &&
      other.firebase_uuid == firebase_uuid &&
      other.phone == phone &&
      other.country == country &&
      other.birthday == birthday;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      f_lastname.hashCode ^
      m_lastname.hashCode ^
      email.hashCode ^
      firebase_uuid.hashCode ^
      phone.hashCode ^
      country.hashCode ^
      birthday.hashCode;
  }

  @override
  List<Object> get props {
    return [
      name,
      f_lastname,
      m_lastname,
      email,
      firebase_uuid,
      phone,
      country,
      birthday,
    ];
  }

  @override
  bool get stringify => true;
}

