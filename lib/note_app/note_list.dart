import 'package:first_app/note_app/add_note.dart';
import 'package:first_app/note_app/utils/DatabaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'model/note.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList = <Note>[];

  @override
  Widget build(BuildContext context) {
    if (noteList.isEmpty) {
      noteList.clear();
      updateListView();
    }

    return Scaffold(
      appBar: getAppBar(),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        tooltip: "AddNote",
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Note('', '', 2), 'Add Note');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getNoteList() {
    debugPrint("Item count ${noteList.length}");
    return ListView.builder(
        itemCount: noteList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10.0,
            child: ListTile(
              leading: CircleAvatar(
                  child: getPriorityIcon(noteList[index].priority), backgroundColor: getPriorityColor(noteList[index].priority)),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  _delete(context, noteList[index]);
                },
              ),
              title: Text(
                noteList[index].title!,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(noteList[index].description!),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(noteList[index], 'Edit Note');
              },
            ),
          );
        });
  }

  void _delete(BuildContext context, Note note) async {
    if (note.id == null) return;
    int result = await databaseHelper.deleteNote(note.id!);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNote(title, note);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
        });
      });
    });
  }

  // Returns the priority color

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

// Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;

      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  getAppBar() {
    return AppBar(
      title: Text("DailyNoteList"),
    );
  }
}
