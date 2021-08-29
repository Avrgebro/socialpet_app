import 'dart:js';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes{

  static String home = '/home';
  static String login = '/login';
  static String register = '/register';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        print('Route was not found.');
      }
    );
  }


}