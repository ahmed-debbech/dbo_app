// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dbo_app/services/BudoService.dart';
import 'package:flutter/material.dart';
import '../utils/utilities.dart';
import '../global.dart' as globals;

class Budokai extends StatefulWidget {
  const Budokai();
  @override
  State<StatefulWidget> createState() => _BudokaiState();
}

class _BudokaiState extends State<Budokai> {
  String timeLeft = "";
  bool isTimeLeftShown = true;
  late Timer _clockTimer;
  String nextEvent = "";
  String nextNotif = "";
  bool notifIsFired = false;
  int time = 0;
  bool isPassed = false;

  BudoService bs = BudoService();

  Future<void> _handleRefresh() async {
    setState(() {});
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      notifIsFired = false;
      isPassed = true;
      bs.getNext();
      bs.getList();
    });

    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        nextEvent = formatDateFromTimestamp(globals.serverNextEvent);
        nextNotif = formatDateFromTimestamp(globals.serverNextNotif);
        timeLeft = calculateTimeLeftForEvent(globals.serverNextEvent);
        if (isEventPassed(globals.serverNextEvent)) {
          isPassed = true;
          return;
        }
        isPassed = false;
        if (shouldFireNotification(globals.serverNextNotif)) {
          notifIsFired = true;
          time = calculateRestTimeToEventAfterNotif(globals.serverNextEvent);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          GestureDetector(
              onDoubleTap: () => _handleRefresh(),
              child: isPassed == true
                  ? Card(
                      color: Color.fromARGB(255, 120, 120, 120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          ListTile(
                            leading: Icon(Icons.replay_rounded),
                            title: Text(
                              'We are working on getting the next event.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Text(
                                "Please come back in few minutes!",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 212, 212, 212)),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ))
                  : notifIsFired == false
                      ? Card(
                          color: Color(0xEEFEB521),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // ignore: prefer_const_constructors
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 10.0, right: 10.0),
                                  child: Text("Adult Solo - Budokai",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          //backgroundColor: Colors.black26,
                                          letterSpacing: 1.0,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                              ListTile(
                                leading: Icon(Icons.panorama_fisheye_outlined),
                                title: Text('Next event will be'),
                                subtitle: Text('$nextEvent'),
                              ),
                              ListTile(
                                leading: Icon(Icons.panorama_fisheye_outlined),
                                title: Text('Next notification is set on'),
                                subtitle: Text('$nextNotif'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "${timeLeft}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 93, 93, 93)),
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Card(
                          color: Color.fromARGB(237, 199, 199, 199),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.fiber_manual_record_sharp),
                                title: Text(
                                    'A new Adult Solo Budokai is starting in ${time} minutes.'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  Text(
                                    "Good luck!",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 93, 93, 93)),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ))),
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Past Budokai events",
                style: TextStyle(
                    color: Color.fromARGB(255, 46, 46, 46),
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                textAlign: TextAlign.left,
              )),
          Expanded(
              child: Material(
                  child: ListView(
            children: [
              for (var ev in globals.firebaseBudoEvents)
                Card(
                    color: Color.fromARGB(236, 236, 236, 236),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.fiber_manual_record_sharp),
                          title: Text('[${ev.fe.name}] ${ev.fe.time}'),
                        ),
                      ],
                    ))
            ],
          )))
        ]));
  }
}
