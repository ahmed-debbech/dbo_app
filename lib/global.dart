library dbo.globals;

import 'package:dbo_app/dto/FirebaseEvent.dart';
import 'package:dbo_app/dto/News.dart';
import 'package:dbo_app/dto/NotifConfig.dart';
import 'package:package_info_plus/package_info_plus.dart';

String api = "http://51.255.48.145:7500";
String versionNum = "1.9.0";

int serverNextEvent = 0;
int serverNextNotif = 0;

List<FirebaseEvent> firebaseBudoEvents = [];

List<String> worldBossTimes = [];

List<News> newsList = [];

int settingsWindow = 0; //0 default 1 news 2 notif

NotifConfig notifConfig = NotifConfig(
      adult_party: false,
      adult_solo: false,
      kid_party: false,
      kid_solo: false,
      dojo_war: false,
      db_scramble: false);

getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
