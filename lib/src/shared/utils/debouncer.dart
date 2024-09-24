class Debouncer {
  final int milliseconds;
  DateTime? _lastTapTime;

  Debouncer({required this.milliseconds});

  bool canExecute() {
    DateTime now = DateTime.now();
    if (_lastTapTime == null ||
        now.difference(_lastTapTime!) > Duration(milliseconds: milliseconds)) {
      _lastTapTime = now;
      return true;
    }
    return false;
  }
}
