import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/modal_bottom_sheet.dart';
import 'package:flutter_stopwatch/util/format_time.dart';
import 'package:flutter_stopwatch/util/stat.dart';

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
    setState(() {
      _stopwatch.isRunning ? _stopwatch.stop() : _stopwatch.start();
    });
  }

  void handleLapReset() {
    setState(() {
      if (_stopwatch.isRunning) {
        _laps.insert(0, _stopwatch.elapsedMilliseconds);
      } else {
        if (_laps.isNotEmpty) {
          modalBottomSheet(context, calculateLapStats(_laps));
        }
        _stopwatch.reset();
        _laps.clear();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? _buildPortraitLayout()
        : _buildLandscapeLayout();
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        if (_laps.isNotEmpty)
          Expanded(
            child: _buildLapList(),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(child: Center(child: _buildClock())),
                Expanded(child: Center(child: _buildControlButtons())),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildPortraitLayout() {
    return Column(
      children: [
        Expanded(child: _buildClock()),
        if (_laps.isNotEmpty) Expanded(child: _buildLapList()),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildControlButtons(),
        )
      ],
    );
  }

  Widget _buildClock() {
    return Center(
      child: Text(
        formatTime(_stopwatch.elapsedMilliseconds),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 56.0,
        ),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_stopwatch.isRunning || _stopwatch.elapsedMilliseconds > 0)
          IconButton.filled(
            onPressed: handleLapReset,
            icon: Icon(
              _stopwatch.isRunning ? Icons.flag_rounded : Icons.stop_rounded,
            ),
          ),
        if (_stopwatch.isRunning || _stopwatch.elapsedMilliseconds > 0)
          const SizedBox(width: 32.0),
        IconButton.filled(
          onPressed: handleStartStop,
          icon: Icon(
            _stopwatch.isRunning
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildLapList() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
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
    );
  }
}
