import 'package:dbo_app/utils/utilities.dart';

class Event {
  String name;
  String time;

  Event({required this.name, required this.time});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        name: json['name'],
        time: formatDateFromISO8601(json['time']));
  }
}
