import 'package:flutter/material.dart';
import 'package:myapp/Calender/Provider/Events_provider.dart';
import 'package:myapp/Calender/calender.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// Screens
import 'Screens/mainDrawer.dart';

void main() async {
  var difference = DateTime.now().second;
  runApp(MyApp());
  AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(
    Duration(minutes: 1),
    0,
    showNotification,
    exact: true,
    startAt: DateTime.now().add(Duration(seconds: 60 - difference)),
    wakeup: true,
    rescheduleOnReboot: false,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventsProvider(),
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          ),
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[500],
      appBar: new AppBar(
        backgroundColor: Colors.red[800],
        title: new Text("Navigation"),
      ),
      drawer: MainDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: new Text(
          "Splash\n Screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontFamily: "Cursive",
          ),
        ),
      ),
    );
  }
}
