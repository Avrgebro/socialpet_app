

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:socialpet/data/models/user.dart';
import 'package:socialpet/ui/home.dart';

var homeHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return HomePage(user: User.fromJson(params['user']!.first));
});
