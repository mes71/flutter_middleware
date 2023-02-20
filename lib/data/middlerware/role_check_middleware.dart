import 'package:flutter_middleware/data/middlerware/middleware.dart';
import 'package:flutter_middleware/data/utils/logger.dart';

class RoleCheckMiddleware extends Middleware {
  @override
  bool check<bool>(String email, String password) {
    if (email == 'admin@gmail.com') {
      'Hello, Admin!'.toSuccessPrint;
      return true as bool;
    }
    'Hello, User!'.toSuccessPrint;
    return checkNext(email, password);
  }
}
