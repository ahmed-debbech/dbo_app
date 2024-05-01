import 'package:flutter/material.dart';

class EventWeek extends StatefulWidget {
  const EventWeek();
  @override
  State<StatefulWidget> createState() => _EventWeekState();
}

class _EventWeekState extends State<EventWeek> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onDoubleTap: () {},
              child: Card(
                      color: Color(0xEEFEB521),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 10.0, right: 10.0),
                                  child: Text("Event of the week",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          //backgroundColor: Colors.black26,
                                          letterSpacing: 1.0,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                          ListTile(
                            leading: Image(
                    opacity: const AlwaysStoppedAnimation(.4),
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.values,
                  ) ,
                            title: Text(
                              'week event name',
                            ),
                          ),
                        ],
                      ))
        );
    }
}