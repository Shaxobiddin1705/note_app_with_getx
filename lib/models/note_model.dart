
import 'dart:convert';

List<Note> imagesFromJson(String str) => List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String imagesToJson(List<Note> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

bool isConnected = false;

class Note{

  late String id;
  late String title;
  late String body;

  Note({required this.title, required this.body});

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    return map;
  }

}