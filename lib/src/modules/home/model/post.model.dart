import 'dart:convert';

import '../../auth/model/user.dart';

class Post {
  final int id;
  String title;
  String description;
  String? image;
  User creator;
  User? updator;
  final DateTime created;
  DateTime updated;

  Post({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.creator,
    this.updator,
    required this.created,
    required this.updated,
  });

  Post copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    User? creator,
    User? updator,
    DateTime? created,
    DateTime? updated,
  }) =>
      Post(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        creator: creator ?? this.creator,
        updator: updator ?? this.updator,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        creator: User.fromJson(json['creator']),
        updator:
            json['updator'] == null ? null : User.fromJson(json['updator']),
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'creator': creator.toJson(),
        'updator': updator?.toJson(),
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };
}
