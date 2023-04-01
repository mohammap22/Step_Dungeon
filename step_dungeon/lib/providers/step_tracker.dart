import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class StepTracker with ChangeNotifier {
  int steps = 0;
  double elevationGain = 0.0;
  StreamSubscription? _stepSubscription;

  void startTracking() {
    _stepSubscription = Pedometer.stepCountStream.listen(
      (event) {
        steps += event.steps;
        notifyListeners();
      },
      onError: (error) {
        print('Error: $error');
      },
    );
  }

  void stopTracking() {
    _stepSubscription?.cancel();
  }

  Future<void> fetchElevationGain() async {
    final random = Random();
    elevationGain = random.nextDouble() * 100.0;
    notifyListeners();
  }

  int calculateXP() {
    return steps + (elevationGain * 2).toInt();
  }
}
