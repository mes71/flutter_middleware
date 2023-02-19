import 'package:flutter_middleware/data/local/fake_data.dart';
import 'package:flutter_middleware/data/middlerware/middleware.dart';
import 'package:flutter_middleware/data/utils/logger.dart';

class UserExistsMiddleware extends Middleware {
  late FakeData _fakeData;

  UserExistsMiddleware(FakeData fakeData) {
    _fakeData = fakeData;
  }

  @override
  bool check(String email, String password) {
    if (!_fakeData.hasEmail(email)) {
      "This email is not registered!".toErrorPrint;
      return false;
    }
    if (!_fakeData.isValidPassword(email, password)) {
      'Wrong Password'.toErrorPrint;
    }

    return checkNext(email, password);
  }
}
