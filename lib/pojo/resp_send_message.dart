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

class RespSendMessage {
  final int ok;

  const RespSendMessage({required this.ok});

  factory RespSendMessage.fromJson(Map<String, dynamic> json) {
    return RespSendMessage(ok: json['res'] == "200 ok" ? 1 : -1);
  }
}

Future<RespSendMessage> holeSendMessage(String message) async {
  final resp = await http.get(Uri.parse('${HoleConfig.getURL()}/api/add_hole_message/core/$message'));
  return RespSendMessage.fromJson(jsonDecode(resp.body));
}
