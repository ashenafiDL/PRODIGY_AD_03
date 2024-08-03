List<int>? calculateLapStats(List<int> cumulativeTimes) {
  if (cumulativeTimes.isEmpty) {
    return null;
  }

  // Calculate lap times from cumulative times
  List<int> lapTimes = [];
  for (int i = 0; i < cumulativeTimes.length; i++) {
    if (i == cumulativeTimes.length - 1) {
      lapTimes.add(cumulativeTimes[i]);
    } else {
      lapTimes.add(cumulativeTimes[i] - cumulativeTimes[i + 1]);
    }
  }

  // Calculate fastest lap
  int fastestLap = lapTimes.reduce((a, b) => a < b ? a : b);

  // Calculate slowest lap
  int slowestLap = lapTimes.reduce((a, b) => a > b ? a : b);

  // Calculate average lap time
  double averageLap = lapTimes.reduce((a, b) => a + b) / lapTimes.length;

  return [fastestLap, slowestLap, averageLap.toInt()];
}
