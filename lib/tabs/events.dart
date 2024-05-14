// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dbo_app/dto/AppState.dart';
import 'package:dbo_app/services/BudoService.dart';
import 'package:dbo_app/tabs/events_one.dart';
import 'package:dbo_app/tabs/events_week.dart';
import 'package:flutter/material.dart';
import '../utils/utilities.dart';
import '../global.dart' as globals;

class AllEvents extends StatelessWidget {
  const AllEvents();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Expanded(
              child: Material(
                  child: ListView(children: [
            EventWeek(),
            EventsOne(title: "adult_solo_budokai"),
            EventsOne(title: "adult_party_budokai"),
            EventsOne(title: "kid_solo_budokai"),
            EventsOne(title: "kid_party_budokai"),
            EventsOne(title: "dojo_war"),
            EventsOne(title: "db_scramble"),
          ])))
        ]));
  }
}
