import 'dart:async';
import 'package:dbo_app/dto/NotifConfig.dart';
import 'package:dbo_app/global.dart' as globals;
import 'package:dbo_app/services/NotificationService.dart';
import 'package:dbo_app/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class NotifTab extends StatefulWidget{
  const NotifTab();
  @override
  State<StatefulWidget> createState() => NotifTabState();
  
}

class NotifTabState extends State<NotifTab> {

  NotificationService ns = NotificationService();

  late NotifConfig? nconf;
  bool loaded = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("intitttt");
    ns.getNotifsForUser().then((value) => {
      setState((){
        if(value != null){
         nconf = value; 
         loaded = true; 
        }else{
          loaded= false;
        }
      })
    });
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
        loaded ? 
        Column(
          children:[
        ListTile(
        title: Text("Notify me for Adult solo budokai"),
        trailing:Checkbox(
                value: nconf?.adult_solo,
                onChanged: (val) {
                  setState((){nconf?.adult_solo = val as bool; });
                  ns.sendChange('adult_solo', val as bool);
                },
              )),
        ListTile(
        title: Text("Notify me for Adult party budokai"),
        trailing:Checkbox(
                value: nconf?.adult_party,
                onChanged: (val) {
                  setState((){nconf?.adult_party = val as bool; });
                  ns.sendChange('adult_party', val as bool);
                },
              )),
        ListTile(
        title: Text("Notify me for Kid solo budokai"),
        trailing:Checkbox(
                value: nconf?.kid_solo,
                onChanged: (val) {
                  setState((){nconf?.kid_solo = val as bool; });
                  ns.sendChange('kid_solo', val as bool);
                },
              )),
        ListTile(
        title: Text("Notify me for Kid party budokai"),
        trailing:Checkbox(
                value: nconf?.kid_party,
                onChanged: (val) {
                  setState((){nconf?.kid_party = val as bool; });
                  ns.sendChange('kid_party', val as bool);
                },
              )),
        ListTile(
        title: Text("Notify me for Dojo War"),
        trailing:Checkbox(
                value: nconf?.dojo_war,
                onChanged: (val) {
                  setState((){nconf?.dojo_war = val as bool; });
                  ns.sendChange('dojo_war', val as bool);
                },
              )),
        ListTile(
        title: Text("Notify me for Db Scramble"),
        trailing:Checkbox(
                value: nconf?.db_scramble,
                onChanged: (val) {
                  setState((){nconf?.db_scramble = val as bool; });
                  ns.sendChange('db_scramble', val as bool);
                },
              ))
    ])
    :
    Center( heightFactor: 12, child: CircularProgressIndicator(), ),

    ]);
  }
}