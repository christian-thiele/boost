// collection of utility methods for generic classes and functions

final _typeListRegex = RegExp('^List(<(.*)>)?\$');
final _typeMapRegex = RegExp('^(_\\w*)?Map(<(.*), (.*)>)?\$');

extension TypeUtils on Type {
  bool get isList {
    final typeStr = toString();
    return _typeListRegex.hasMatch(typeStr);
  }

  bool get isMap {
    final typeStr = toString();
    return _typeMapRegex.hasMatch(typeStr);
  }

  bool isListOfType<TValue>() {
    final typeStr = toString();
    final match = _typeListRegex.firstMatch(typeStr);

    if (match == null) {
      return false;
    }

    if (match.groupCount < 2) {
      return false;
    }

    return match.group(2) == TValue.toString();
  }

  bool isMapOfType<TKey, TValue>() {
    final typeStr = toString();
    final match = _typeMapRegex.firstMatch(typeStr);

    if (match == null) {
      return false;
    }

    if (match.groupCount < 4) {
      return false;
    }

    return match.group(3) == TKey.toString() &&
        match.group(4) == TValue.toString();
  }
}
