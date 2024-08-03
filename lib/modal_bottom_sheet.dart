import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/util/format_time.dart';

void modalBottomSheet(context, stats) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 32.0,
          right: 32.0,
          top: 32.0,
          bottom: 8.0,
        ),
        child: Wrap(
          children: [
            Text(
              'Stats',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32.0),
            StatRow(
              text: 'Fastest Lap',
              value: formatTime(stats[0]),
            ),
            const Divider(),
            StatRow(
              text: 'Slowest Lap',
              value: formatTime(stats[1]),
            ),
            const Divider(),
            StatRow(
              text: 'Average Lap Time',
              value: formatTime(stats[2]),
            ),
            const SizedBox(height: 40.0),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: FilledButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        const Spacer(),
        Text(value),
      ],
    );
  }
}
