import 'dart:async';

class Debounce {
  static final Map<String, Timer> _debounceTimers = {}; // 存储多个计时器

  static void run(String key, Function() callback, Duration duration) {
    if (_debounceTimers.containsKey(key)) {
      _debounceTimers[key]!.cancel();
    }
    _debounceTimers[key] = Timer(duration, () {
      callback();
      _debounceTimers.remove(key);
    });
  }

  static void dispose(String key) {
    if (_debounceTimers.containsKey(key)) {
      _debounceTimers[key]!.cancel();
      _debounceTimers.remove(key);
    }
  }

  static Function debounce(Function fn, [int delay = 1000]) {
    Timer? timer;
    return () {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(Duration(milliseconds: delay), () {
        fn();
      });
    };
  }
}