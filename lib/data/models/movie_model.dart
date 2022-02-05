import 'dart:convert';

import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final String title;
  final String description;
  final String posterUrl;
  const MovieModel({
    required this.title,
    required this.description,
    required this.posterUrl,
  });

  MovieModel copyWith({
    String? title,
    String? description,
    String? posterUrl,
  }) {
    return MovieModel(
      title: title ?? this.title,
      description: description ?? this.description,
      posterUrl: posterUrl ?? this.posterUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'posterUrl': posterUrl,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      posterUrl: map['posterUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [title, description, posterUrl];
}
