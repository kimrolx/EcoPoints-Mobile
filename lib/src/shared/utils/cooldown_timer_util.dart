import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class CooldownTimerUtil {
  final Map<String, Timer?> _cooldownTimers = {};
  final Map<String, int> _secondsRemainingMap = {};
  final Map<String, StreamController<int>> _streamControllers = {};
  final int cooldownDuration;

  CooldownTimerUtil({this.cooldownDuration = 180});

  // Method to start or resume the cooldown with a specific number of seconds
  void startCooldownWithSeconds(String userId, int seconds) {
    // Cancel any existing cooldown
    _cooldownTimers[userId]?.cancel();

    // Initialize stream controller if not already present
    if (!_streamControllers.containsKey(userId)) {
      _streamControllers[userId] = StreamController<int>.broadcast();
    }

    _secondsRemainingMap[userId] = seconds;

    // Save cooldown start time to Firestore
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'lastEmailVerificationSent': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));

    // Start countdown timer
    _cooldownTimers[userId] =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemainingMap[userId]! > 0) {
        _secondsRemainingMap[userId] = _secondsRemainingMap[userId]! - 1;
        _streamControllers[userId]?.add(_secondsRemainingMap[userId]!);
      } else {
        _cooldownTimers[userId]?.cancel();
        _secondsRemainingMap[userId] = 0;
        _streamControllers[userId]?.add(0);
        _streamControllers[userId]?.close();
        _streamControllers.remove(userId);
        _cooldownTimers.remove(userId);
      }
    });
  }

  bool isCooldownActive(String userId) {
    return _cooldownTimers.containsKey(userId) &&
        _cooldownTimers[userId]?.isActive == true &&
        _secondsRemainingMap[userId]! > 0;
  }

  Stream<int> getCooldownStream(String userId) {
    if (!_streamControllers.containsKey(userId)) {
      _streamControllers[userId] = StreamController<int>.broadcast();
    }
    return _streamControllers[userId]!.stream;
  }

  void dispose(String userId) {
    _cooldownTimers[userId]?.cancel();
    _cooldownTimers.remove(userId);
    _streamControllers[userId]?.close();
    _streamControllers.remove(userId);
  }
}
