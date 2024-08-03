String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  var millis = (milliseconds % 100).toString().padLeft(2, '0');
  return "$minutes:$seconds.$millis";
}
