class NextEvent {
  String nextEvent;
  String nextNotification;

  NextEvent({
    required this.nextEvent,
    required this.nextNotification,
  });

  factory NextEvent.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty ||
        !json.containsKey("nextEvent") ||
        !json.containsKey("nextNotification")) {
      return NextEvent(nextEvent: '0', nextNotification: '0');
    }
    if (json["nextEvent"] == null) {
      return NextEvent(
        nextEvent: '0',
        nextNotification: json["nextNotification"],
      );
    }
    if (json["nextNotification"] == null) {
      return NextEvent(
        nextEvent: json["nextEvent"],
        nextNotification: '0',
      );
    }
    return NextEvent(
      nextEvent: json["nextEvent"],
      nextNotification: json["nextNotification"],
    );
  }

  Map<String, dynamic> toJson() =>
      {"nextEvent": nextEvent, "nextNotification": nextNotification};
}
