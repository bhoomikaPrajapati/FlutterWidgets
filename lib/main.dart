import 'package:first_app/note_app/note_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NoteList(),
    theme: ThemeData(
      primaryColor: Colors.deepPurple,
      accentColor: Colors.deepPurpleAccent,
      primaryColorDark: Colors.deepPurple,
      primarySwatch: Colors.deepPurple,
    ),
  ));

/*  runApp(MaterialApp(
      title: "Exploring UI widgets",
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            debugPrint("click on floating button");
          },
          child: Icon(Icons.add),
          tooltip: "Add one more item",
        ),
        appBar: AppBar(
          title: Text("Exploring UI widgets"),
        ),
        body: ListViewExample(),
      )));*/
}
