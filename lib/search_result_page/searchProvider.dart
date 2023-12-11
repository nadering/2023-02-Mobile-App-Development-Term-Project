import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  String _value = '';

  String get value => _value;

  void setValue(String newValue) {
    _value = newValue;
    notifyListeners(); // 리스너들에게 값이 변경되었음을 알립니다.
  }
}