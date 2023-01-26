import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import 'hole_message.dart';

class HoleReport {
  final int ok;

  const HoleReport({required this.ok});

  factory HoleReport.fromJson(Map<String, dynamic> json) {
    return HoleReport(ok: json['res'] == "200 ok" ? 1 : -1);
  }
}

Utf8Decoder utf8decoder = const Utf8Decoder();

Future<HoleReport> reportHoleMessage(HoleMessage holeMessage) async {
  final resp = await http.get(Uri.parse('${HoleConfig.getURL()}/api/report_message/${holeMessage.id}'));
  return HoleReport.fromJson(jsonDecode(resp.body));
}
