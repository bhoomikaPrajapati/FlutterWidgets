import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      margin: EdgeInsets.only(top: 30.0),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),
          child: Text(
            "Submit",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () => openDialog(context)),
    );
  }

  void openDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Dialog"),
      content: Text("Successfully open"),
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
