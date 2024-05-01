// ignore_for_file: prefer_const_constructors

import 'dart:async';

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
            children: const <Widget>[
              EventWeek(),
              EventsOne(),
              EventsOne(),
            ]));
  }
}
