import 'dart:ffi';

import 'package:intl/intl.dart';

String formatDateFromTimestamp(int timestamp) {
  DateTime a = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String datetime = a.toLocal().toIso8601String().toString();
  var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
  var inputDate = inputFormat.parse(datetime);
  var outputFormat = DateFormat('dd MMMM hh:mm a');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

String calculateTimeLeftForEvent(int ts) {
  DateTime a = DateTime.fromMillisecondsSinceEpoch(ts).toLocal();
  DateTime b = DateTime.now();
  Duration difference = a.difference(b);
  int days = difference.inDays;
  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;
  String timeLeft = "${days}d ${hours}h ${minutes}m ${seconds}s.";
  return timeLeft;
}

bool shouldFireNotification(int serverNextNotif) {
  return DateTime.fromMillisecondsSinceEpoch(serverNextNotif, isUtc: true)
      .toUtc()
      .isBefore(DateTime.now().toUtc());
}

int calculateRestTimeToEventAfterNotif(int serverNextEvent) {
  DateTime a = DateTime.fromMillisecondsSinceEpoch(serverNextEvent).toLocal();
  DateTime b = DateTime.now();
  Duration difference = a.difference(b);
  int minutes = difference.inMinutes % 60;
  return minutes;
}

bool isEventLive(int maxNumberOfPassedMin, int timestamp) {
  DateTime a = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
  DateTime b = DateTime.now();
  Duration difference = b.difference(a);
  int minutes = difference.inMinutes;
  if (minutes <= maxNumberOfPassedMin) return true;
  return false;
}

bool isEventPassed(int serverNextEvent) {
  if (DateTime.now().toLocal().isAfter(
      DateTime.fromMillisecondsSinceEpoch(serverNextEvent).toLocal())) {
    return true;
  }
  return false;
}

String formatDateFromISO8601(String time) {
  String dd = DateTime.fromMillisecondsSinceEpoch(int.parse(time))
      .toLocal()
      .toIso8601String();
  DateTime now = DateTime.parse(dd);
  var formatter = DateFormat('dd MMMM - hh:mm a');
  var formatted = formatter.format(now);
  return formatted;
}

int fromISO8601ToTimestamp(String iso) {
  DateTime dateTime = DateTime.parse(iso);
  int unixTimestamp = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  return unixTimestamp;
}
