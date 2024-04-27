library dbo.globals;

import 'package:dbo_app/dto/FirebaseEvent.dart';
import 'package:dbo_app/dto/News.dart';
import 'package:package_info_plus/package_info_plus.dart';

String api = "http://192.168.1.5:7500";
String versionNum = "1.9.0";

int serverNextEvent = 0;
int serverNextNotif = 0;

List<FirebaseEvent> firebaseBudoEvents = [];

List<String> worldBossTimes = [];

List<News> newsList = [];

getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
