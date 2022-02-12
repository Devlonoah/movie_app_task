class MovieResultModel {
  MovieResultModel({
    required this.data,
    required this.meta,
  });
  List<Data>? data;
  Meta? meta;

  MovieResultModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.map((e) => e.toJson()).toList();
    _data['meta'] = meta!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.attributes,
  });
  int? id;
  Attributes? attributes;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = Attributes.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes!.toJson();
    return _data;
  }
}

class Attributes {
  Attributes({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.publicationYear,
    required this.genres,
    required this.owner,
    required this.poster,
  });
  String? name;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  int? publicationYear;
  Genres? genres;
  Owner? owner;
  Poster? poster;

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    publicationYear = json['publicationYear'];
    genres = Genres.fromJson(json['genres']);
    owner = Owner.fromJson(json['owner']);
    poster = Poster.fromJson(json['poster']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['publicationYear'] = publicationYear;
    _data['genres'] = genres?.toJson();
    _data['owner'] = owner?.toJson();
    _data['poster'] = poster?.toJson();
    return _data;
  }
}

class Genres {
  Genres({
    required this.data,
  });
  List<dynamic>? data;

  Genres.fromJson(Map<String, dynamic> json) {
    data = List.castFrom<dynamic, dynamic>(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data;
    return _data;
  }
}

class Owner {
  Owner({
    required this.data,
  });
  Data? data;

  Owner.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Poster {
  Poster({
    required this.data,
  });
  Data? data;

  Poster.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Meta {
  Meta({
    required this.pagination,
  });
  Pagination? pagination;

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = Pagination.fromJson(json['pagination']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagination'] = pagination?.toJson();
    return _data;
  }
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['pageSize'] = pageSize;
    _data['pageCount'] = pageCount;
    _data['total'] = total;
    return _data;
  }
}
