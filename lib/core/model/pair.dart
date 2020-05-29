import 'package:flutter/foundation.dart';

@immutable
class Pair<K,V> {
  final K key;
  final V value;

  const Pair(this.key, this.value);

  @override
  int get hashCode => (shortHash(key) + shortHash(value)).hashCode;

  @override
  bool operator ==(other) {
    if (other is Pair) {
      return key == other.key && value == other.value;
    }
    return super == other;
  }

  @override
  String toString() => "($key, $value)";
}