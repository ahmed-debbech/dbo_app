// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dbo_app/dto/AppState.dart';
import 'package:dbo_app/dto/NotifConfig.dart';
import 'package:dbo_app/services/BudoService.dart';
import 'package:dbo_app/services/NotificationService.dart';
import 'package:dbo_app/services/PushNotificationService.dart';
import 'package:dbo_app/tabs/events_one.dart';
import 'package:dbo_app/tabs/events_week.dart';
import 'package:flutter/material.dart';
import '../utils/utilities.dart';
import '../global.dart' as globals;

class AllEvents extends StatefulWidget {
  AllEvents({super.key});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class Sortable {
  String name = "";
  int time = 0;
  bool isLive;
  Sortable({required this.name, required this.time, required this.isLive});
}

class _AllEventsState extends State<AllEvents> {
  BudoService bs = BudoService();
  NotificationService ns = NotificationService();

  late Timer _timer;
  List<Sortable> names = [];
  NotifConfig? nc = null;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    ns.getNotifsForUser().then((value) => {
          nc = value,
          _timer = Timer.periodic(Duration(seconds: 1), (timer) {
            if (globals.appState != null) {
              globals.appState!.past_kid_party_budokai = "1716214520000";
              setState(() {
                names.add(Sortable(
                    name: "adult_party_budokai",
                    time: int.parse(globals.appState!.adult_party_budokai),
                    isLive: isEventLiveS(
                        30, globals.appState!.past_adult_party_budokai ?? "")));
                names.add(Sortable(
                    name: "adult_solo_budokai",
                    time: int.parse(globals.appState!.adult_solo_budokai),
                    isLive: isEventLiveS(
                        30, globals.appState!.past_adult_solo_budokai ?? "")));
                names.add(Sortable(
                    name: "kid_party_budokai",
                    time: int.parse(globals.appState!.kid_party_budokai),
                    isLive: isEventLiveS(
                        30, globals.appState!.past_kid_party_budokai ?? "")));
                names.add(Sortable(
                    name: "kid_solo_budokai",
                    time: int.parse(globals.appState!.kid_solo_budokai),
                    isLive: isEventLiveS(
                        30, globals.appState!.past_kid_solo_budokai ?? "")));
                names.add(Sortable(
                    name: "dojo_war",
                    time: int.parse(globals.appState!.dojo_war),
                    isLive: isEventLiveS(
                        30, globals.appState!.past_dojo_war ?? "")));
                names.add(Sortable(
                    name: "db_scramble",
                    time: int.parse(globals.appState!.db_scramble),
                    isLive: isEventLiveS(
                        30, globals.appState!.past_db_scramble ?? "")));
                names.sort((a, b) => a.time - b.time);
                names = shiftToHead(names);

                names = removeUnecessary(names, nc);
                _timer.cancel();
              });
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    bs.getState();

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Expanded(
              child: Material(
                  child: ListView(children: [
            EventWeek(),
            for (int i = 0; i <= names.length - 1; i++)
              EventsOne(title: names[i].name)
          ])))
        ]));
  }
}
