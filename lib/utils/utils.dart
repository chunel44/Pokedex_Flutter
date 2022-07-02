import 'dart:math';
import 'dart:core';

class Util {
  static int next(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min);
  }
}
