
import 'dart:convert';

import 'package:http/http.dart';
import 'package:note_app_with_getx/models/note_model.dart';

class Network{

  static String baseApi = "620a799192946600171c5aa7.mockapi.io";

  static Map<String, String> headers = {'Content-type': 'application/json; charset=UTF-8',};


  /* Http Requests */

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(baseApi, api, params); // http or https
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async{
    var uri = Uri.https(baseApi, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, dynamic> params) async{
    var uri = Uri.https(baseApi, api, params);
    var response = await delete(uri, headers: headers);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> UPDATE(String api, Map<String, dynamic> params) async{
    var uri = Uri.https(baseApi, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Apis */
  static String API_GET = "/api/note-patterns";
  static String API_POST = "/api/note-patterns";
  static String API_DELETE = "/api/note-patterns/"; //{id}
  static String API_UPDATE = "/api/note-patterns/"; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, dynamic> paramsPost(Note note) {
    Map<String, dynamic> params = {};
    params.addAll({
      'title': note.title,
      'body': note.body,
    });
    return params;
  }

  static Map<String, dynamic> paramsUpdate(Note note) {
    Map<String, dynamic> params = {};
    params.addAll({
      'title': note.title,
      'body': note.body,
    });
    return params;
  }

  /* Http parsing */
  static List<Note> parseResponse(String response) {
    List json = jsonDecode(response);
    List<Note> notes = List<Note>.from(json.map((x) => Note.fromJson(x)));
    return notes;
  }
}