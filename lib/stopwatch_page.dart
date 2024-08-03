import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/util/format_time.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  final List<int> _laps = [];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }

    setState(() {});
  }

  void handleLapReset() {
    if (_stopwatch.isRunning) {
      _laps.insert(0, _stopwatch.elapsedMilliseconds);
    } else {
      _stopwatch.reset();
      _laps.clear();
    }

    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              formatTime(_stopwatch.elapsedMilliseconds),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 56.0,
              ),
            ),
          ),
        ),
        if (_laps.isNotEmpty)
          Expanded(
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Lap'),
                      Text('Lap Time'),
                      Text('Total Time'),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ListView.builder(
                      itemCount: _laps.length,
                      itemBuilder: (context, index) {
                        final lapTime = index == _laps.length - 1
                            ? _laps[index]
                            : _laps[index] - _laps[index + 1];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${_laps.length - index}'),
                              Text('+${formatTime(lapTime)}'),
                              Text(formatTime(_laps[index])),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_stopwatch.isRunning || _stopwatch.elapsedMilliseconds > 0)
                IconButton.filled(
                  onPressed: handleLapReset,
                  icon: Icon(
                    _stopwatch.isRunning ? Icons.flag : Icons.stop,
                  ),
                ),
              if (_stopwatch.isRunning || _stopwatch.elapsedMilliseconds > 0)
                const SizedBox(width: 32.0),
              IconButton.filled(
                onPressed: handleStartStop,
                icon: Icon(
                  _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
