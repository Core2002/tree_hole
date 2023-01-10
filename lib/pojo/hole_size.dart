import 'dart:convert';
import 'package:http/http.dart' as http;

class HoleSize {
  final int size;

  const HoleSize({required this.size});

  factory HoleSize.fromJson(Map<String, dynamic> json) {
    return HoleSize(size: json['size']);
  }
}

Utf8Decoder utf8decoder = const Utf8Decoder();

Future<HoleSize> getHoleSize() async {
  final resp = await http.get(Uri.parse('http://192.168.1.3:8080/api/read_hole_size/core'));
  return HoleSize.fromJson(jsonDecode(resp.body));
}
