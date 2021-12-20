import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/chart_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/semicircle.dart';

class HomePage extends StatefulWidget {
  double? temperature;
  DatabaseError? error;
  HomePage({this.temperature, this.error});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get color => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Temperature'),
      )),
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.9),
                ])),
          ),
          SemiCircleWidget(
              sweepAngle: ((30 - 15) * 12.0).clamp(0.0, 125.0),
              color: Colors.blue),
          Container(
            child: Center(
              child: widget.error == null
                  ? Text(
                      '${widget.temperature}°C',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    )
                  : Text(
                      'Error retrieving button tap count:\n${widget.error!.message}'),
            ),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
