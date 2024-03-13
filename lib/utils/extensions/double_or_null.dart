extension ParseToDoubleOrNull on String {
  double? parseToDoubleOrNull() {
    if (isEmpty) {
      return null;
    } else {
      try {
        return double.parse(this);
      } catch (e) {
        // Parsing failed
        return null;
      }
    }
  }
}
