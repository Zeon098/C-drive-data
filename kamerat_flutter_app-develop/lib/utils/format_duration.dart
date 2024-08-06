String formatDuration(int seconds) {
  Duration duration = Duration(seconds: seconds);

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitsHours = twoDigits(duration.inHours);
  String twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));

  String formattedDuration = "";

  if (twoDigitsHours != "00") {
    formattedDuration += "${twoDigitsHours}h ";
  }

  formattedDuration += "${twoDigitsMinutes}m ";

  if (twoDigitsSeconds != "00") {
    formattedDuration += "${twoDigitsSeconds}s ";
  }

  return formattedDuration;
}
