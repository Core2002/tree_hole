import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import 'hole_message.dart';

class HoleLike {
  final int ok;

  const HoleLike({required this.ok});

  factory HoleLike.fromJson(Map<String, dynamic> json) {
    return HoleLike(ok: json['res'] == "200 ok" ? 1 : -1);
  }
}

Utf8Decoder utf8decoder = const Utf8Decoder();

Future<HoleLike> likeHoleMessage(HoleMessage holeMessage) async {
  final resp = await http.get(Uri.parse('${HoleConfig.getURL()}/api/like_message/${holeMessage.id}'));
  return HoleLike.fromJson(jsonDecode(resp.body));
}
