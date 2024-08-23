import 'dart:async';

class CooldownTimerUtil {
  Timer? _cooldownTimer;
  final int cooldownDuration;
  int _secondsRemaining;
  bool isCooldownActive = false;
  final _secondsStreamController = StreamController<int>.broadcast();

  CooldownTimerUtil({this.cooldownDuration = 180}) : _secondsRemaining = 0;

  int get secondsRemaining => _secondsRemaining;
  Stream<int> get secondsStream => _secondsStreamController.stream;

  void startCooldown() {
    if (_cooldownTimer == null || !_cooldownTimer!.isActive) {
      _secondsRemaining = cooldownDuration;
      isCooldownActive = true;
      _secondsStreamController.add(_secondsRemaining); //* Notify listeners
      _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _secondsStreamController.add(_secondsRemaining); //* Notify listeners
        } else {
          _cooldownTimer?.cancel();
          isCooldownActive = false;
          _secondsStreamController.add(_secondsRemaining); //* Notify listeners
        }
      });
    }
  }

  void stopCooldown() {
    _cooldownTimer?.cancel();
    _secondsRemaining = 0;
    isCooldownActive = false;
    _secondsStreamController.add(_secondsRemaining); //* Notify listeners
  }

  bool isTimerActive() {
    return isCooldownActive;
  }

  void dispose() {
    _cooldownTimer?.cancel();
    _secondsStreamController.close();
  }
}
