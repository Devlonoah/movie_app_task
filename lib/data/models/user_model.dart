import 'dart:convert';

// {
//     "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiaWF0IjoxNjQ0NDgwOTUwLCJleHAiOjE2NDcwNzI5NTB9.TBkRCzbkJaV5uEJycW1UeUUf733B9dIRxbb9g2Ueo9g",
//     "user": {
//         "id": 7,
//         "username": "devlonoah",
//         "email": "devlonoah@gmail.com",
//         "provider": "local",
//         "confirmed": true,
//         "blocked": false,
//         "createdAt": "2022-02-04T16:39:09.919Z",
//         "updatedAt": "2022-02-04T16:39:09.919Z"
//     }
// }

class UserModel {
  final String? jwt;
  final int? id;
  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    this.jwt,
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      jwt: map['jwt'],
      id: map['user']['id'],
      username: map['user']['username'],
      email: map['user']['email'],
      provider: map['user']['provider'],
      confirmed: map['user']['confirmed'],
      blocked: map['user']['blocked'],
      createdAt: map['user']['createdAt'],
      updatedAt: map['user']['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jwt': jwt,
      'id': id,
      'username': username,
      'email': email,
      'provider': provider,
      'confirmed': confirmed,
      'blocked': blocked,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
}
