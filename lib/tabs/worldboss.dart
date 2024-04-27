import 'dart:async';

import 'package:dbo_app/services/BossService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/utilities.dart';
import '../global.dart' as globals;

class Boss extends StatefulWidget {
  const Boss();
  @override
  State<StatefulWidget> createState() => BossState();
}

class BossState extends State<Boss> {
  BossService bs = BossService();
  late Timer _clockTimer;

  List<String> list = [];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      bs.getList();
    });
    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        list = globals.worldBossTimes;
      });
    });
  }

  List<Widget> _buildCardWidgets() {
    List<Widget> textWidgets = []; // Add an empty Container as a default widget
    for (int i = 0; i <= globals.worldBossTimes.length - 1; i++) {
      textWidgets.add(Card(
        color: Color.fromARGB(237, 241, 241, 241),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.panorama_fisheye_outlined),
              title: Text(
                  "${formatDateFromTimestamp(int.parse(globals.worldBossTimes[i]))}"),
            )
          ],
        ),
      ));
    }

    return textWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Past World Boss events",
            style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.bold,
                fontSize: 24),
            textAlign: TextAlign.left,
          )),
      list.isEmpty
          ? const Column(children: [
              Text("World Boss events will be shown here as they come")
            ])
          : Expanded(
              child: Material(child: ListView(children: _buildCardWidgets())))
    ]);
  }
}
