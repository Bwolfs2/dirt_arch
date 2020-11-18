import 'dart:convert';

class SampleModel {
  final int userId;
  final int id;
  final String title;

  final bool completed;
  final String urlImage;
  SampleModel(
      {this.userId, this.id, this.title, this.completed, this.urlImage});

  SampleModel copyWith({
    int userId,
    int id,
    String title,
    bool completed,
    String urlImage,
  }) =>
      SampleModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        urlImage: urlImage ?? this.urlImage,
      );

  factory SampleModel.fromJson(String str) =>
      SampleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SampleModel.fromMap(dynamic json) => SampleModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
        urlImage: json['urlImage'],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
        'urlImage': urlImage,
      };
}
