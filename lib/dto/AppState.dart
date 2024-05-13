import 'package:dbo_app/utils/utilities.dart';

class AppState{

  String? event_of_the_week;
  List<int> current_events;
  String adult_solo_budokai;
  String adult_party_budokai;
  String kid_solo_budokai;
  String kid_party_budokai;
  String dojo_war;
  String db_scramble;

  AppState({
    required this.event_of_the_week, 
    required this.current_events,
    required this.adult_solo_budokai,
    required this.adult_party_budokai,
    required this.kid_solo_budokai,
    required this.kid_party_budokai,
    required this.dojo_war,
    required this.db_scramble
  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
        event_of_the_week: json['event_of_the_week'],
        //current_events: formatDateFromISO8601(json['time'])
        current_events: json["current_events"].cast<int>(),
        adult_solo_budokai: formatDateFromISO8601(json["adult_solo_budokai"]),
        adult_party_budokai: formatDateFromISO8601(json["adult_party_budokai"]),
        kid_solo_budokai: formatDateFromISO8601(json["kid_solo_budokai"]),
        kid_party_budokai: formatDateFromISO8601(json["kid_party_budokai"]),
        dojo_war: formatDateFromISO8601(json["dojo_war"]),
        db_scramble: formatDateFromISO8601(json["db_scramble"]),
    );
  }
}