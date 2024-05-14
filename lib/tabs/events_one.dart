import 'dart:async';

import 'package:dbo_app/services/BudoService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../utils/utilities.dart';
import '../global.dart' as globals;

class EventsOne extends StatefulWidget {
  String title = "";
  EventsOne({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _EventsOneState();
}

class _EventsOneState extends State<EventsOne> {
  String timeLeft = "";
  bool isTimeLeftShown = true;
  late Timer _clockTimer;
  String nextEvent = "";
  String nextNotif = "";
  bool notifIsFired = false;
  int time = 0;
  bool isPassed = false;
  String iconName = "";
  String eventName = "";
  int timestamp = 0;

  BudoService bs = BudoService();

  _EventsOneState();

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
    });

    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (globals.appState == null) {
          eventName = "null";
          timestamp = 0;
        } else {
          switch (widget.title) {
            case "adult_solo_budokai":
              iconName = "budo.png";
              eventName = "Adult Solo - Budokai";
              timestamp = int.parse(globals.appState!.adult_solo_budokai);
              break;
            case "adult_party_budokai":
              iconName = "budo.png";
              eventName = "Adult Party - Budokai";
              timestamp = int.parse(globals.appState!.adult_party_budokai);
              break;
            case "kid_solo_budokai":
              iconName = "budo.png";
              eventName = "Kid Solo - Budokai";
              timestamp = int.parse(globals.appState!.kid_solo_budokai);
              break;
            case "kid_party_budokai":
              iconName = "budo.png";
              eventName = "Kid Party - Budokai";
              timestamp = int.parse(globals.appState!.kid_party_budokai);
              break;
            case "dojo_war":
              iconName = "dojo.png";
              eventName = "Dojo War";
              timestamp = int.parse(globals.appState!.dojo_war);
              break;
            case "db_scramble":
              iconName = "scrum.png";
              eventName = "DB Scrumble";
              timestamp = int.parse(globals.appState!.db_scramble);
              break;
            default:
              eventName = "xxx";
              timestamp = 1715863141000;
              break;
          }
        }
        nextEvent = formatDateFromTimestamp(timestamp);
        nextNotif = formatDateFromTimestamp(timestamp);
        timeLeft = calculateTimeLeftForEvent(timestamp);
        if (isEventPassed(timestamp)) {
          isPassed = true;
          return;
        }
        isPassed = false;
        if (shouldFireNotification(timestamp)) {
          notifIsFired = true;
          time = calculateRestTimeToEventAfterNotif(timestamp);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () => _handleRefresh(),
        child: isPassed == true
            ? Card(
                color: Color.fromARGB(255, 210, 210, 210),
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
            : Card(
                    color: Color.fromARGB(235, 234, 179, 28), //Color.fromARGB(237, 241, 241, 241),
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
                            child: Row(children: [
                              Container(
                                  color: Colors
                                      .transparent, // To see the difference between the image's original size and the frame
                                  height: 24,
                                  width: 24,

                                  // Uploading the Image from Assets
                                  child: (iconName == "")
                                      ? Image.asset(
                                          "assets/images/budo.png",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/${iconName}",
                                          fit: BoxFit.cover,
                                        )),
                              SizedBox(width: 10),
                              Text("${eventName}",
                                  style: TextStyle(
                                      //backgroundColor: Colors.black26,
                                      letterSpacing: 1.0,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ])),
                        ListTile(
                          leading: ShaderMask(
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect bounds) {
                                return RadialGradient(
                                  center: Alignment.center,
                                  radius: 1.0,
                                  colors: [Colors.red, Colors.transparent],
                                  stops: [0.0, 1.0],
                                ).createShader(bounds);
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  child: Icon(
                                      color: Colors.red,
                                      Icons.fiber_manual_record_sharp))),
                          title: Text('Next event will be'),
                          subtitle: Text('$nextEvent'),
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
               );
  }
}
