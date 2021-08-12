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
        RoutePath("Home", "", "home"),
        new ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CalculatorApp()));
          },
          title: Container(
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.calculate),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Calculator",
                      ),
                    ),
                  ),
                ],
              ),
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
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.quiz),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Quiz App",
                      ),
                    ),
                  ),
                ],
              ),
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
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.calendar_today),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Calender",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // new ListTile(
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => ExpenceMain()));
        //   },
        //   title: Container(
        //     child: Expanded(
        //       child: Row(
        //         children: <Widget>[
        //           Expanded(
        //             flex: 1,
        //             child: Icon(Icons.person),
        //           ),
        //           Expanded(
        //             flex: 7,
        //             child: Padding(
        //               padding: EdgeInsets.only(left: 10),
        //               child: Text(
        //                 "Personal Expences",
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    ));
  }
}
