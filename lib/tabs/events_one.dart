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
  late Timer _clockTimer;
  String nextEvent = "";
  int time = 0;
  bool isLive = false;
  String iconName = "";
  String? eventName = "loading...";
  int timestamp = 0;
  int last = 0;

  BudoService bs = BudoService();

  _EventsOneState();

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      isLive = false;
    });

    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (globals.appState == null) {
          eventName = "loading...";
          timestamp = 0;
          last = 0;
        } else {
          switch (widget.title) {
            case "adult_solo_budokai":
              iconName = "budo.png";
              eventName = "Adult Solo - Budokai";
              timestamp = int.parse(globals.appState!.adult_solo_budokai);
              last = int.parse(globals.appState?.past_adult_solo_budokai == null
                  ? "0"
                  : globals.appState?.past_adult_solo_budokai ?? "");
              break;
            case "adult_party_budokai":
              iconName = "budo.png";
              eventName = "Adult Party - Budokai";
              timestamp = int.parse(globals.appState!.adult_party_budokai);
              last = int.parse(
                  globals.appState?.past_adult_party_budokai == null
                      ? "0"
                      : globals.appState?.past_adult_party_budokai ?? "");
              break;
            case "kid_solo_budokai":
              iconName = "budo.png";
              eventName = "Kid Solo - Budokai";
              timestamp = int.parse(globals.appState!.kid_solo_budokai);
              last = int.parse(globals.appState?.past_kid_solo_budokai == null
                  ? "0"
                  : globals.appState?.past_kid_solo_budokai ?? "");
              break;
            case "kid_party_budokai":
              iconName = "budo.png";
              eventName = "Kid Party - Budokai";
              timestamp = int.parse(globals.appState!.kid_party_budokai);
              last = int.parse(globals.appState?.past_kid_party_budokai == null
                  ? "0"
                  : globals.appState?.past_kid_party_budokai ?? "");

              break;
            case "dojo_war":
              iconName = "dojo.png";
              eventName = "Dojo War";
              timestamp = int.parse(globals.appState!.dojo_war);
              last = int.parse(globals.appState?.past_dojo_war == null
                  ? "0"
                  : globals.appState?.past_dojo_war ?? "");
              break;
            case "db_scramble":
              iconName = "scrum.png";
              eventName = "DB Scrumble";
              timestamp = int.parse(globals.appState!.db_scramble);
              last = int.parse(globals.appState?.past_db_scramble == null
                  ? "0"
                  : globals.appState?.past_db_scramble ?? "");
              break;
            default:
              eventName = "not set";
              timestamp = 0;
              last = 0;
              isLive = false;
              break;
          }
        }
        nextEvent = formatDateFromTimestamp(timestamp);
        timeLeft = calculateTimeLeftForEvent(timestamp);
        //check for 30 min from last
        bool passed = isEventPassed(timestamp);
        if (passed) {
          isLive = true;
        } else {
          isLive = isEventLive(30, last);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (globals.appState == null)
        ? const Center(
            heightFactor: 12,
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onDoubleTap: () => {},
            child: isLive == false
                ? Card(
                    color: const Color.fromARGB(237, 241, 241, 241),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        Padding(
                            padding: const EdgeInsets.only(
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
                              const SizedBox(width: 10),
                              Text("${eventName}",
                                  style: const TextStyle(
                                      //backgroundColor: Colors.black26,
                                      letterSpacing: 1.0,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ])),
                        ListTile(
                          leading:
                              const Icon(Icons.fiber_manual_record_outlined),
                          title: const Text('Next event will be'),
                          subtitle: Text('$nextEvent'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "${timeLeft}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ],
                    ),
                  )
                : Card(
                    color: const Color.fromARGB(235, 234, 179,
                        28), //Color.fromARGB(237, 241, 241, 241),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        Padding(
                            padding: const EdgeInsets.only(
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
                              const SizedBox(width: 10),
                              Text("${eventName}",
                                  style: const TextStyle(
                                      //backgroundColor: Colors.black26,
                                      letterSpacing: 1.0,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ])),
                        ListTile(
                          leading: ShaderMask(
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect bounds) {
                                return const RadialGradient(
                                  center: Alignment.center,
                                  radius: 1.0,
                                  colors: [Colors.red, Colors.transparent],
                                  stops: [0.0, 1.0],
                                ).createShader(bounds);
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  child: const Icon(
                                      color: Colors.red,
                                      Icons.fiber_manual_record_sharp))),
                          title: const Text('Next event will be'),
                          subtitle: Text('$nextEvent'),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Running now!",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 39, 24)),
                            ),
                            SizedBox(width: 15),
                          ],
                        ),
                      ],
                    ),
                  ));
  }
}
