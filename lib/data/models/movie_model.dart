import 'dart:convert';

class MovieResultModel {
  final List<Movies>? movieResult;

  MovieResultModel(this.movieResult);

  Map<String, dynamic> toMap() {
    return {
      'data': movieResult?.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieResultModel.fromMap(Map<String, dynamic> map) {
    return MovieResultModel(
      map['data'] != null
          ? List<Movies>.from(map['data']?.map((x) => Movies.fromMap(x)))
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieResultModel.fromJson(String source) =>
      MovieResultModel.fromMap(json.decode(source));
}

class Movies {
  final String id;

  final Attributes attributes;

  Movies(this.id, this.attributes);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attributes': attributes.toMap(),
    };
  }

  factory Movies.fromMap(Map<String, dynamic> map) {
    return Movies(
      map['id'].toString() ?? '',
      Attributes.fromMap(map['attributes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movies.fromJson(String source) => Movies.fromMap(json.decode(source));
}

//attributes
class Attributes {
  final String name;
  final String publicationYear;

  final Poster? poster;

  Attributes({
    required this.name,
    required this.publicationYear,
    this.poster,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'publicationYear': publicationYear,
      'poster': poster?.toMap(),
    };
  }

  factory Attributes.fromMap(Map<String, dynamic> map) {
    return Attributes(
      name: map['name'] ?? '',
      publicationYear: map['publicationYear'].toString() ?? '',
      poster: map['poster']['data']['attributes']['formats'] != null
          ? Poster.fromMap(map['poster']['data']['attributes']['formats'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attributes.fromJson(String source) =>
      Attributes.fromMap(json.decode(source));
}

class Poster {
  final String? large;

  final String? small;

  final String? medium;

  final String? thumbnail;

  Poster(
    this.large,
    this.small,
    this.medium,
    this.thumbnail,
  );

  Map<String, dynamic> toMap() {
    return {
      'large': large,
      'small': small,
      'medium': medium,
      'thumbnail': thumbnail,
    };
  }

  factory Poster.fromMap(Map<String, dynamic> map) {
    return Poster(
      map['large']['url'],
      map['small']['url'],
      map['medium']['url'],
      map['thumbnail']['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Poster.fromJson(String source) => Poster.fromMap(json.decode(source));
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    return data;
  }
}
