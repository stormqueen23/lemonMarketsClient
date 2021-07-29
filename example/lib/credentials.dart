import 'package:flutter/material.dart';
import 'dart:convert';

class Credentials {
  late String clientId;
  late String clientSecret;
  late String spaceUuid;

  Future<void> init(BuildContext context) async {
    debugPrint("try to load asset file credentials.json");
    try {
      String jsonString = await DefaultAssetBundle.of(context).loadString('assets/credentials.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      clientId = jsonMap['clientId'];
      clientSecret = jsonMap['clientSecret'];
      spaceUuid = jsonMap['spaceUuid'];
    } on FlutterError catch (e) {
      clientId = "";
      clientSecret = "";
      spaceUuid = "";
      debugPrint(e.toString());
    }
  }


}