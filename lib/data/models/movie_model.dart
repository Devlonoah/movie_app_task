// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// class MovieModel extends Equatable {
//   final String title;
//   final String description;
//   final String posterUrl;
//   const MovieModel({
//     required this.title,
//     required this.description,
//     required this.posterUrl,
//   });

//   MovieModel copyWith({
//     String? title,
//     String? description,
//     String? posterUrl,
//   }) {
//     return MovieModel(
//       title: title ?? this.title,
//       description: description ?? this.description,
//       posterUrl: posterUrl ?? this.posterUrl,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'description': description,
//       'posterUrl': posterUrl,
//     };
//   }

//   factory MovieModel.fromMap(Map<String, dynamic> map) {
//     return MovieModel(
//       title: map['title'] ?? '',
//       description: map['description'] ?? '',
//       posterUrl: map['posterUrl'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MovieModel.fromJson(String source) =>
//       MovieModel.fromMap(json.decode(source));

//   @override
//   List<Object?> get props => [title, description, posterUrl];
// }

// To parse this JSON data, do
//
//     final movieResultModel = movieResultModelFromMap(jsonString);

import 'dart:convert';

class MovieResultModel {
  MovieResultModel({
    required this.data,
    required this.meta,
  });

  List<Movie> data;
  Meta meta;

  factory MovieResultModel.fromJson(String str) =>
      MovieResultModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieResultModel.fromMap(Map<String, dynamic> json) =>
      MovieResultModel(
        data: List<Movie>.from(json["data"].map((x) => Movie.fromJson(x)))
            .toList(),
        meta: Meta.fromMap(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "data": List<Movie>.from(data.map((x) => x)),
        "meta": meta.toMap(),
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromMap(json["pagination"]),
      );

  Map<String, dynamic> toMap() => {
        "pagination": pagination.toMap(),
      };
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  int page;
  int pageSize;
  int pageCount;
  int total;

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}

class Movie {
  final String title;
  final String publishingYear;
  final String poster;

  Movie({
    required this.title,
    required this.publishingYear,
    required this.poster,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'publishingYear': publishingYear,
      'poster': poster,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      publishingYear: map['publishingYear'] ?? '',
      poster: map['poster'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
