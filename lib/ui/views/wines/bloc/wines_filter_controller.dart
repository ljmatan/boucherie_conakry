import 'dart:async';

abstract class WinesFilterController {
  static int _currentlySelected;
  static int get currentlySelected => _currentlySelected;

  static StreamController _streamController;

  static void init() => _streamController = StreamController.broadcast();

  static Stream get stream => _streamController.stream;

  static void change(value) {
    _streamController.add(value);
    _currentlySelected = value;
  }

  static void dispose() {
    _streamController.close();
    _currentlySelected = null;
  }
}
