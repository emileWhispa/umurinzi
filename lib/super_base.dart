import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'json/user.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class Superbase {
  String server = "https://apis.umurinzi.rw/shop/";

  String userKey = "user-key-val";
  String jwtKey = "kgsl";

  String idKeyUser = 'id-user-data-BASE64-key-123';
  String idKey = 'user-id-23';

  var platform = MethodChannel('app.channel.shared.data');

  Color color = Color(0xff014E84);

  void toast(String string) {
    platform.invokeMethod("toast", string);
  }

  String url(String url) => "$server$url";

  BoxDecoration get decoration => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.pink.shade300,
            Colors.pink.shade200,
            Colors.pink.shade100,
            Colors.pink.shade50,
            Colors.white,
            Colors.white,
            Colors.white,
          ]));

  Future<void> save(String key, dynamic val) {
    return saveVal(key, jsonEncode(val));
  }

  Future<void> saveVal(String key, String value) async {
    (await prefs).setString(key, value);
    return Future.value();
  }

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  void auth(String jwt, String user, String id) {
    prefs.then((SharedPreferences prf) {
      if (jwt != null) prf.setString(jwtKey, jwt);
      if (user != null) prf.setString(idKeyUser, user);
      if (id != null) prf.setString(idKey, id);
    });
  }

  bool canDecode(String jsonString) {
    var decodeSucceeded = false;
    try {
      json.decode(jsonString);
      decodeSucceeded = true;
    } on FormatException {}
    return decodeSucceeded;
  }

  Future<void> ajax(
      {@required String url,
      String method: "GET",
      FormData data,
      Map<String, dynamic> map,
      bool server: false,
      bool auth: true,
      bool local: false,
      bool base2: false,
      String authKey,
      bool json: true,
      bool absolutePath: false,
      ResponseType responseType: ResponseType.json,
      bool localSave: false,
      String jsonData,
      void Function(dynamic response, String url) onValue,
      void Function() onEnd,
      void Function(dynamic response, String url) error}) async {
    url = absolutePath ? url : this.url(url);

    Map<String, String> headers = new Map<String, String>();

    var prf = await prefs;
    if (auth && authKey != null) {
      headers['token'] = '$authKey';
    }

    Options opt = Options(
        responseType: responseType,
        headers: headers,
        receiveDataWhenStatusError: true,
        sendTimeout: 30000,
        receiveTimeout: 30000);

    if (!server) {
      String val = prf.get(url);
      bool t = onValue != null && val != null;
      local = local && t;
      localSave = localSave && t;
      var c = (t && json && canDecode(val)) || !json;
      t = t && c;
      if (t) onValue(json ? jsonDecode(val) : val, url);
    }

    if (local) {
      if (onEnd != null) onEnd();
      return Future.value();
    }

    Future<Response> future = method.toUpperCase() == "POST"
        ? Dio().post(url, data: jsonData ?? map ?? data, options: opt)
        : method.toUpperCase() == "PUT"
            ? Dio().put(url, data: jsonData ?? map ?? data, options: opt)
            : method.toUpperCase() == "DELETE"
                ? Dio().delete(url, data: jsonData ?? map ?? data, options: opt)
                : Dio().get(url, options: opt);

    try {
      Response response = await future;
      dynamic data = response.data;
      if (response.statusCode == 200) {
        //var cond = (data is String && json && canDecode(data)) || !json;
        this.saveVal(url, jsonEncode(data));

        if (onValue != null && !localSave)
          onValue(data, url);
        else if (error != null) error(data, url);
      } else if (error != null) {
        error(data, url);
      }
    } on DioError catch (e) {
      //if (e.response != null) {
      var resp = e.response != null ? e.response.data : e.message;
      if (error != null) error(resp, url);
      //}
    }

    if (onEnd != null) onEnd();
    return Future.value();
  }

  void signedIn(
      void Function(String token, User user) function, void Function() not) {
    prefs.then((SharedPreferences prf) {
      String b = prf.get(jwtKey);
      String v = prf.get(idKeyUser);

      if (v != null) {
        Map<String, dynamic> _map = json.decode(v);
        function(b, User.fromJson(_map));
      } else
        not();
    });
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
