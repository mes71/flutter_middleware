import 'dart:collection';

import 'package:flutter_middleware/data/middlerware/middleware.dart';
import 'package:flutter_middleware/data/utils/logger.dart';

class FakeData {
  final Map<String, String> users = HashMap();
  Middleware? _middleware;

  set setMiddleware(Middleware value) {
    _middleware = value;
  }

  bool logIn(String email, String password) {
    if (_middleware!.check(email, password)) {
      'Authorization have been successful!'.toSuccessPrint;
      return true;
    }
    return false;
  }

  void register(String email, String password) => users[email] = password;

  bool hasEmail(String email) => users.containsKey(email);

  bool isValidPassword(String email, String password) =>
      users[email] == password;
}
