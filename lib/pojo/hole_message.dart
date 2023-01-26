import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/config.dart';

class HoleMessage {
  final String id;
  final String hole;
  String message;
  int like;
  final DateTime date;
  final String ip;

  HoleMessage({
    required this.id,
    required this.hole,
    required this.message,
    required this.like,
    required this.date,
    required this.ip,
  });

  factory HoleMessage.fromJson(Map<String, dynamic> json) {
    return HoleMessage(
      id: json['_id'],
      hole: json['hole'],
      message: json['message'],
      like: json['like'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      ip: json['ip'],
    );
  }
}

Utf8Decoder utf8decoder = const Utf8Decoder();
Future<HoleMessage> getMESSAGE(index) async {
  final response = await http.get(Uri.parse('${HoleConfig.getURL()}/api/read_index/core/$index'));
  if (response.statusCode == 200) {
    return HoleMessage.fromJson(jsonDecode(utf8decoder.convert(response.bodyBytes)));
  } else {
    throw Exception('Failed to load MESSAGE');
  }
}
