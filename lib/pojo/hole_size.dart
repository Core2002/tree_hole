/*
 * Copyright 2023 Core2002
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *           http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
