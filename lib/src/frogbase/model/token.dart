import 'dart:convert' show json;

import '../../db/hive.dart';
import '../../utils/extensions/extensions.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config/constants.dart';

part 'token.g.dart';
part 'token.ext.dart';

@HiveType(typeId: HiveTypes.token)
class Token {

  @HiveField(0)
  String accessToken;
  @HiveField(1)
  String refreshToken;

  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json[_Json.accessToken] as String,
        refreshToken: json[_Json.refreshToken] as String,
      );

  factory Token.fromRawJson(String source) =>
      Token.fromJson(json.decode(source));

  Map<String, dynamic> toJson() => {
        _Json.accessToken: accessToken,
        _Json.refreshToken: refreshToken,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() =>
      'Token{accessToken: $accessToken, refreshToken: $refreshToken}';
}

class _Json {
  static const accessToken = 'access-token';
  static const refreshToken = 'refresh-token';
}
