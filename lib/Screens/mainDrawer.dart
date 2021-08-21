import 'package:flutter/material.dart';

// Screens
import './routePath.dart';
import '../calculator.dart';
import '../Quiz/Quiz.dart';
// import '../Personal Expences/ExpenceMain.dart';
import '../Calender/calender.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      height: double.infinity,
      child: ListView(
        children: [
          new UserAccountsDrawerHeader(
            margin: EdgeInsets.only(bottom: 0),
            accountName: new Text("Deepak Dhiman"),
            accountEmail: new Text("deepak.kumar@cyberoisystems.com"),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new AssetImage('assets/images/panther.png'),
            ),
          ),
          RoutePath("Home", "", Icons.home),
          new ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalculatorApp()));
            },
            title: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.calculate),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Calculator",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QuizApp()));
            },
            title: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.quiz),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Quiz App",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Calender()));
            },
            title: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Calender",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
