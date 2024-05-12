import 'dart:async';

import 'package:dbo_app/services/BossService.dart';
import 'package:flutter/material.dart';
import '../utils/utilities.dart';
import '../global.dart' as globals;

class Boss extends StatefulWidget {
  const Boss();
  @override
  State<StatefulWidget> createState() => BossState();
}

class BossState extends State<Boss> {
  BossService bs = BossService();

  Color yellow = Color.fromARGB(255, 182, 167, 34);
  Color green = Color.fromARGB(255, 63, 160, 30);
  Color red = Color.fromARGB(255, 179, 31, 31);

  String eta = "0";
  String percentage = "0";
  bool loaded = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loaded = false;
    });
    bs.getPercentage().then((value) => {
      setState(() {
        print(value);
        if(value["percentage"] != "-1"){ 
          percentage = value["percentage"];
          if(value["eta"] == null){
            eta = "0";
          }else{
            eta = value["eta"];
          }
          loaded = true;
        }else{
          loaded = false;
        }
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "World Boss Progress",
            style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.bold,
                fontSize: 24),
            textAlign: TextAlign.left,
          )),
          (loaded == false)?
              Center( heightFactor: 12, child: CircularProgressIndicator(), )
          :
          Column(
            children:[
          (double.parse(percentage)<= 50.0) ?
          Center(
            child: Text(
              "${percentage}%",
              style: TextStyle(
                fontSize: 40,
                color: green
              ),
              ),
          )
          :
          ((double.parse(percentage) > 50.0) && (double.parse(percentage) < 80.0))?
                    Center(
            child: Text(
              "${percentage}%",
              style: TextStyle(
                fontSize: 40,
                color: yellow
              ),
              ),
          )
          :
                    Center(
            child: Text(
              "${percentage}%",
              style: TextStyle(
                fontSize: 40,
                color: red
              ),
              ),
          )
          ,
          (eta == "0")?
            Column(children: [
              Text("ETA is coming soon ~")
            ])
            :
            Column(children: [
              Text("Average ETA ${eta}~"),
              Text("Keep in mind, this may be inaccurate")
                ])
             ])
    ]);
  }
}
