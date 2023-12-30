import 'dart:convert' show json;

import '../../../utils/extensions/extensions.dart';
import 'package:hive/hive.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';

part 'user.ext.dart';
part 'user.g.dart';


@HiveType(typeId: HiveTypes.user)
class User  extends HiveObject{

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String email;
  @HiveField(3)
  String name;
  @HiveField(4)
  String? avatar;
  @HiveField(5)
  DateTime updated;
  @HiveField(6)
  final DateTime created;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    this.avatar,
    required this.updated,
    required this.created,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json[_Json.id] as int,
        username: json[_Json.username] as String,
        email: json[_Json.email] as String,
        name: json[_Json.name] as String,
        avatar: json[_Json.avatar] as String?,
        updated: DateTime.parse(json['updated'] as String).toLocal(),
        created: DateTime.parse(json['created'] as String).toLocal(),
      );

  factory User.fromRawJson(String source) => User.fromJson(json.decode(source));

  // to json
  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.username: username,
        _Json.email: email,
        _Json.name: name,
        _Json.avatar: avatar,
        _Json.updated: updated.toUtc().toIso8601String(),
        _Json.created: created.toUtc().toIso8601String(),
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'User{id: $id, username: $username, email: $email, name: $name, avatar: $avatar, updated: $updated, created: $created}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const username = 'username';
  static const email = 'email';
  static const name = 'name';
  static const avatar = 'avatar';
  static const updated = 'updated';
  static const created = 'created';
}
