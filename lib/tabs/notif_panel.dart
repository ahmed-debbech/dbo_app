import 'dart:async';
import 'package:dbo_app/global.dart' as globals;
import 'package:dbo_app/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class NotifTab extends StatefulWidget{
  const NotifTab();
  @override
  State<StatefulWidget> createState() => NotifTabState();
  
}

class NotifTabState extends State<NotifTab> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("intitttt");
  }


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
          flex: 2,
          child:
            Padding(
          padding: EdgeInsets.all(10),
            child: 
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                globals.settingsWindow = 0;
              },
            )
          )),
          Expanded(
          flex: 8,
          child:
          const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Notification Panel",
            style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.bold,
                fontSize: 24),
            textAlign: TextAlign.left,
          ))
          ),
        ]),
        ListTile(
        title: Text("Notify me for Adult solo budokai"),
        trailing:Checkbox(
                value: true,
                onChanged: (val) {
                  //_onSelected(val, data[i]);
                },
              )),
        ListTile(
        title: Text("Notify me for Adult party budokai"),
        trailing:Checkbox(
                value: true,
                onChanged: (val) {
                  //_onSelected(val, data[i]);
                },
              )),
        ListTile(
        title: Text("Notify me for Kid solo budokai"),
        trailing:Checkbox(
                value: true,
                onChanged: (val) {
                  //_onSelected(val, data[i]);
                },
              )),
        ListTile(
        title: Text("Notify me for Kid party budokai"),
        trailing:Checkbox(
                value: true,
                onChanged: (val) {
                  //_onSelected(val, data[i]);
                },
              )),
        ListTile(
        title: Text("Notify me for Dojo War"),
        trailing:Checkbox(
                value: true,
                onChanged: (val) {
                  //_onSelected(val, data[i]);
                },
              )),
        ListTile(
        title: Text("Notify me for Db Scramble"),
        trailing:Checkbox(
                value: true,
                onChanged: (val) {
                  //_onSelected(val, data[i]);
                },
              ))
    ]);
  }
}