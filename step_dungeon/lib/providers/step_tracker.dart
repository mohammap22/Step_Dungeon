import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';
import 'package:health/health.dart';
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
    final permissionStatus = await PermissionHandler.requestPermission(
        permission: PermissionType.activityRecognition);

    if (permissionStatus.isGranted) {
      final now = DateTime.now();
      final startDate = DateTime(now.year, now.month, now.day);

      List<HealthDataPoint> elevationData = await health.getHealthDataFromType(
        startDate,
        now,
        HealthDataType.ELEVATION,
      );

      elevationGain = elevationData.fold(
        0.0,
        (sum, data) => sum + data.value,
      );
      notifyListeners();
    }
  }

  int calculateXP() {
    return steps + (elevationGain * 2).toInt();
  }
}
