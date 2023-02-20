import 'package:flutter_middleware/data/middlerware/middleware.dart';
import 'package:flutter_middleware/data/utils/logger.dart';

class ThrottlingMiddleware extends Middleware {
  final int _requestPerMinute;

  late int _request;

  int? _currentTime;

  ThrottlingMiddleware(this._requestPerMinute) {
    _currentTime = DateTime.now().millisecondsSinceEpoch;
    _request = 0;
  }

  @override
  bool check<bool>(String email, String password) {
    if (DateTime.now().millisecondsSinceEpoch > (_currentTime! + 60000)) {
      _request = 0;
      _currentTime = DateTime.now().millisecond;
    }
    _request++;
    if (_request > _requestPerMinute) {
      'Request limit exceeded!'.toErrorPrint;
      return false as bool;
    }
    return checkNext(email, password);
  }
}
