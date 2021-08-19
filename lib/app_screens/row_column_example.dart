import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_example.dart';
import 'image_example.dart';

class RowColumnExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        color: Colors.blue,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Spice jet",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 30,
                      fontFamily: "OpenSans",
                      color: Colors.white),
                )),
                Expanded(
                    child: Text(
                  "From Mumbai to Bangalore via new delhi",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontFamily: "OpenSans",
                      color: Colors.white),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Spice jet",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 30,
                      fontFamily: "OpenSans",
                      color: Colors.white),
                )),
                Expanded(
                    child: Text(
                  "From Mumbai to Bangalore via new delhi",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontFamily: "OpenSans",
                      color: Colors.white),
                )),
              ],
            ),
            ImageExample(),
            ButtonExample()
          ],
        ));
  }
}
