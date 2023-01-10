import 'dart:convert';
import 'package:http/http.dart' as http;

class MESSAGE {
  final String hole;
  final String message;
  final int like;
  final int date;
  final String ip;

  const MESSAGE({
    required this.hole,
    required this.message,
    required this.like,
    required this.date,
    required this.ip,
  });

  factory MESSAGE.fromJson(Map<String, dynamic> json) {
    return MESSAGE(
      hole: json['hole'],
      message: json['message'],
      like: json['like'],
      date: json['date'],
      ip: json['ip'],
    );
  }
}

Utf8Decoder utf8decoder = const Utf8Decoder();
Future<MESSAGE> getMESSAGE(index) async {
  final response = await http
      .get(Uri.parse('http://192.168.1.3:8080/api/read_index/core/$index'));
  if (response.statusCode == 200) {
    return MESSAGE
        .fromJson(jsonDecode(utf8decoder.convert(response.bodyBytes)));
  } else {
    throw Exception('Failed to load MESSAGE');
  }
}
