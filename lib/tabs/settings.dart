import 'dart:async';

import 'package:dbo_app/tabs/news.dart';
import 'package:dbo_app/tabs/notif_panel.dart';
import 'package:flutter/material.dart';
import 'package:dbo_app/global.dart' as globals;

class SettingsTab extends StatefulWidget{
  const SettingsTab({super.key});

  
  @override
  State<SettingsTab> createState() => SettingsTabState();
}

class SettingsTabState extends State<SettingsTab>{

  late Timer _clockTimer;
  
  int settings = 0;

  @override
  void dispose(){
    super.dispose();
    _clockTimer.cancel();
  }
  
  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(Duration(seconds: 0), (timer) {
      setState(() {
        settings = globals.settingsWindow;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String ver = globals.versionNum;

    return  
      settings == 0 ?
       Column(
      children: [
        Center(
          child:
        OutlinedButton(onPressed: () { globals.settingsWindow = 1; }, 
            child: const Text("🔥 See what's new in the app"),
            
          )),
          Center(
          child:
             OutlinedButton(onPressed: () { globals.settingsWindow = 2; }, 
            child: const Text("🔔 Choose events to be notified about"),
            
          )),
          Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                      child: Card(
                          color: const Color.fromARGB(237, 199, 199, 199),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.verified_user_outlined),
                                title: Text('You are running version: $ver'),
                              ),
                              const ListTile(
                                leading: Icon(Icons.warning_amber_rounded),
                                title: Text('This is an Unoffical app of DBOG'),
                              ),
                              const ListTile(
                                  leading: Icon(Icons.code_rounded),
                                  title: InkWell(
                                    onTap: null,
                                    child:
                                        Text('Made with ❤️ by Ahmed Debbech'),
                                  )),
                            ],
                          ),
                        )))),
      ],
    )
    :
    settings == 2 ?
    NotifTab()
    :
    settings == 1 ?
    NewsTab() : Column();
  }
}