import 'Event.dart';

class FirebaseEvent {
  String uuid;
  Event fe;

  FirebaseEvent({
    required this.uuid,
    required this.fe,
  });

  factory FirebaseEvent.fromJson(Map<String, dynamic> json) {
    return FirebaseEvent(uuid: json["uuid"], fe: Event.fromJson(json["fe"]));
  }
}
