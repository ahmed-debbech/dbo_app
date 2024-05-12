class NotifConfig{
  bool adult_solo;
  bool adult_party;
  bool kid_solo;
  bool kid_party;
  bool dojo_war;
  bool db_scramble;

  NotifConfig({
    required this.adult_party,
    required this.adult_solo,
    required this.kid_party,
    required this.kid_solo,
    required this.dojo_war,
    required this.db_scramble,
  });

  factory NotifConfig.fromJson(Map<String, dynamic> json) {
    if(json.isEmpty) {
      return NotifConfig(
      adult_party: false,
      adult_solo: false,
      kid_party: false,
      kid_solo: false,
      dojo_war: false,
      db_scramble: false);
    }

      return NotifConfig(
      adult_party: json["adult_party"],
      adult_solo: json["adult_solo"],
      kid_party: json["kid_party"],
      kid_solo: json["kid_solo"],
      dojo_war: json["dojo_war"],
      db_scramble: json["db_scramble"]);
  }
}