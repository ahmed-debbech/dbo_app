import 'dart:async';

import 'package:dbo_app/dto/News.dart';
import 'package:dbo_app/global.dart' as globals;
import 'package:dbo_app/services/NewsService.dart';
import 'package:dbo_app/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTab extends StatefulWidget{
  const NewsTab();
  @override
  State<StatefulWidget> createState() => NewsState();
  
}

class NewsState extends State<NewsTab> {

  NewsService ns = NewsService();

  List<News> list = [];

  late Timer _clockTimer;

  @override
  void dispose() {
    super.dispose();
    _clockTimer.cancel();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      ns.getAll();
    });
    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        list = globals.newsList;
      });
    });
  }
  Widget _buildCardWidgets() {
    List<Widget> textWidgets = []; // Add an empty Container as a default widget
    for (int i = 0; i <= globals.newsList.length - 1; i++) {
      textWidgets.add(Card(
        color: Color.fromARGB(237, 241, 241, 241),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.fiber_new_sharp),
              title: Text("${globals.newsList[i].title}",
                style: TextStyle(fontSize: 25),),
              subtitle: Text("${globals.newsList[i].text}"),
            ),
            Row(children: [
              SizedBox(width: 10),
            Text(style: TextStyle(fontSize: 10),
              "${formatDateFromTimestamp(int.parse(globals.newsList[i].time))}")],)
          ],
        ),
      ));
    }
    return Expanded(
              child: Material(
                  child: ListView(
                  children: textWidgets)));
  }
  @override
  Widget build(BuildContext context) {
    String ver = globals.versionNum;
    return  Center(
              child: Column(
                  children: [
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
             "    What's new 🔥",
            style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.bold,
                fontSize: 24),
            textAlign: TextAlign.left,
          ))
          ),
        ]),
                    list.isEmpty ?
                    Text("News about the app will be here.")
                    :
                    _buildCardWidgets()
                  ],
                ));
  }
}

