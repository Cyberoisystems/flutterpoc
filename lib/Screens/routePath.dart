import 'package:flutter/material.dart';

class RoutePath extends StatelessWidget {
  final String PathName;
  final String PathUrl;
  final String IconName;
  RoutePath(this.PathName, this.PathUrl, this.IconName);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
      },
      title: Container(
        child: Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(Icons.home),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    PathName,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
