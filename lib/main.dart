import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/chart_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyC1SxtELI9XqPKUtUjb5i2Zd_98QrONpOw',
    appId: '1:739195271250:android:140a51c31896b89c14478b',
    messagingSenderId: '739195271250',
    projectId: 'projectcoop-1e520',
    databaseURL: 'https://projectcoop-1e520-default-rtdb.firebaseio.com',
  ));
  runApp(MaterialApp(
    title: 'Flutter Database Example',
    home: MyHomePage(app: app),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.app}) : super(key: key);

  final FirebaseApp app;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // koko
  double temperature = 0;
  late DatabaseReference _temperatureRef;
  late StreamSubscription<Event> _temperatureSubscription;
  DatabaseError? error;

  void initState() {
    super.initState();
    _temperatureRef =
        FirebaseDatabase.instance.reference().child('temperature');

    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    database
        .reference()
        .child('temperature')
        .get()
        .then((DataSnapshot? snapshot) {
      print(
          'Connected to directly configured database and read ${snapshot!.value}');
    });
    database.setLoggingEnabled(true);

    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(10000000);
      _temperatureRef.keepSynced(true);
    }

    _temperatureSubscription = _temperatureRef.onValue.listen((Event event) {
      setState(() {
        error = null;
        temperature = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError _error = o as DatabaseError;
      setState(() {
        error = _error;
      });
    });
  }

  // koko
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.blue,
          body: TabBarView(
            children: [
              HomePage(
                temperature: temperature,
                error: error,
              ),
              Charts(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.thermostat_rounded),
                text: 'Temperature',
              ),
              Tab(
                icon: Icon(Icons.bar_chart_rounded),
                text: 'Chart',
              ),
            ],
          )),
    );
  }
}
