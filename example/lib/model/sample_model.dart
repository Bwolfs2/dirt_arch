import 'dart:convert';

class SampleModel {
  SampleModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  final int userId;
  final int id;
  final String title;
  final bool completed;

  SampleModel copyWith({
    int userId,
    int id,
    String title,
    bool completed,
  }) =>
      SampleModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
      );

  factory SampleModel.fromJson(String str) =>
      SampleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SampleModel.fromMap(Map<String, dynamic> json) => SampleModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
