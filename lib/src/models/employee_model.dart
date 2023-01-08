import 'dart:convert';

List<Game> employeeFromJson(String str) =>
    List<Game>.from(json.decode(str).map((x) => Game.fromJson(x)));

String employeeToJson(List<Game> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Game {
  int? id;
  String? title;
  String? platform;

  Game({
    this.id,
    this.title,
    this.platform,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        title: json["title"],
        platform: json["platform"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "platform": platform,
      };
}
