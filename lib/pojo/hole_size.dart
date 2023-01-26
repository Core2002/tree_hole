import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/config.dart';

class HoleSize {
  final int size;

  const HoleSize({required this.size});

  factory HoleSize.fromJson(Map<String, dynamic> json) {
    return HoleSize(size: json['size']);
  }
}

Utf8Decoder utf8decoder = const Utf8Decoder();

Future<HoleSize> getHoleSize() async {
  final resp = await http.get(Uri.parse('${HoleConfig.getURL()}/api/read_hole_size/core'));
  return HoleSize.fromJson(jsonDecode(resp.body));
}
