import 'package:flutter/material.dart';

class RoutePath extends StatelessWidget {
  final String PathName;
  final String PathUrl;
  final IconData iconData;
  const RoutePath(this.PathName, this.PathUrl, this.iconData);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
      },
      title: Container(
        child: Row(
          children: <Widget>[
            Icon(iconData),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  PathName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
