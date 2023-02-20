import 'package:flutter_middleware/data/middlerware/middleware.dart';

abstract class AuthMiddleware extends Middleware {
  @override
  bool check<bool>(String email, String password);

  @override
  bool checkNext<bool>(String email, String password) {
    return super.checkNext(email, password);
  }
}
