import 'package:flutter_middleware/data/middlerware/middleware.dart';
import 'package:flutter_middleware/data/utils/logger.dart';

class ThrottlingMiddleware extends Middleware {
  final int _requestPerMinute;

  late int _request;

  int? _currentTime;

  ThrottlingMiddleware(this._requestPerMinute) {
    _currentTime = DateTime.now().millisecond;
  }

  @override
  bool check(String email, String password) {
    if (DateTime.now().millisecond > (_currentTime! + 60000)) {
      _request = 0;
      _currentTime = DateTime.now().millisecond;
    }
    _request++;
    if (_request > _requestPerMinute) {
      'Request limit exceeded!'.toErrorPrint;
    }
    return checkNext(email, password);
  }
}
