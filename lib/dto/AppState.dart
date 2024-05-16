import 'package:dbo_app/utils/utilities.dart';

class AppState{

  String? event_of_the_week;
  String? special_event;

  List<int> current_events;
  String adult_solo_budokai;
  String? past_adult_solo_budokai;

  String adult_party_budokai;
  String? past_adult_party_budokai;

  String kid_solo_budokai;
  String? past_kid_solo_budokai;

  String kid_party_budokai;
  String? past_kid_party_budokai;

  String dojo_war;
  String? past_dojo_war;

  String db_scramble;
  String? past_db_scramble;

  AppState({
    required this.event_of_the_week, 
    required this.special_event, 
    required this.current_events,

    required this.adult_solo_budokai,
    this.past_adult_solo_budokai,

    required this.adult_party_budokai,
    this.past_adult_party_budokai,

    required this.kid_solo_budokai,
    this.past_kid_solo_budokai,

    required this.kid_party_budokai,
    this.past_kid_party_budokai,

    required this.dojo_war,
    this.past_dojo_war,

    required this.db_scramble,
    this.past_db_scramble

  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
        event_of_the_week: json['event_of_the_week'],
        special_event: json['special_event'],

        current_events: json["current_events"].cast<int>(),
        adult_solo_budokai: (json["adult_solo_budokai"]),
        past_adult_solo_budokai: (json["past_adult_solo_budokai"]),

        adult_party_budokai: (json["adult_party_budokai"]),
        past_adult_party_budokai: (json["past_adult_party_budokai"]),

        kid_solo_budokai: (json["kid_solo_budokai"]),
        past_kid_solo_budokai: (json["past_kid_solo_budokai"]),

        kid_party_budokai: (json["kid_party_budokai"]),
        past_kid_party_budokai: (json["past_kid_party_budokai"]),

        dojo_war: (json["dojo_war"]),
        past_dojo_war: (json["past_dojo_war"]),

        db_scramble: (json["db_scramble"]),
        past_db_scramble: (json["past_db_scramble"]),

    );
  }
}