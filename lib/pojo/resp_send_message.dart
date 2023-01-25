import 'dart:convert';
import 'package:http/http.dart' as http;

class RespSendMessage {
  final int ok;

  const RespSendMessage({required this.ok});

  factory RespSendMessage.fromJson(Map<String, dynamic> json) {
    return RespSendMessage(ok: json['res'] == "200 ok" ? 1 : -1);
  }
}

Future<RespSendMessage> holeSendMessage(String message) async {
  final resp = await http.get(Uri.parse('http://192.168.1.3:8080/api/add_hole_message/core/$message'));
  return RespSendMessage.fromJson(jsonDecode(resp.body));
}
