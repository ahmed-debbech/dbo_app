import 'dart:async';

import 'package:dbo_app/dto/AppState.dart';
import 'package:flutter/material.dart';
import '../global.dart' as globals;

class EventWeek extends StatefulWidget {
  const EventWeek();

  @override
  State<StatefulWidget> createState() => _EventWeekState();
}

class _EventWeekState extends State<EventWeek> {
  late Timer _clockTimer;
  List<int> available = [];
  String? eventWeek = "";

  @override
  void dispose() {
    super.dispose();
    _clockTimer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (globals.appState == null) {
          eventWeek = null;
          available = [];
        } else {
          eventWeek = globals.appState?.event_of_the_week;
          available = globals.appState!.current_events;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {},
        child: Card(
            color: Color.fromARGB(237, 254, 121, 33), //Color(0xEEFEB521),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: Text("Event of the week",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            //backgroundColor: Colors.black26,
                            letterSpacing: 1.0,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
                ListTile(
                  leading: Text("eee"),
                  title: Text(
                    'week event name',
                  ),
                ),
              ],
            )));
  }
}
