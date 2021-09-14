import 'package:first_app/note_app/model/note.dart';
import 'package:first_app/note_app/utils/DatabaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  AddNote(this.appBarTitle, this.note);

  @override
  State<StatefulWidget> createState() {
    return AddNoteState(this.appBarTitle, this.note);
  }
}

class AddNoteState extends State<AddNote> {
  var priority = ["High", "Low"];
  var _selectedPriority;
  String appBarTitle;
  DatabaseHelper helper = DatabaseHelper();
  Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AddNoteState(this.appBarTitle, this.note);

  initState() {
    super.initState();
    this._selectedPriority = priority[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;

    titleController.text = note.title ??= "";
    descriptionController.text = note.description ??= "";

    return WillPopScope(
        onWillPop: () async {
          moveToLastScreen();
          var otherNavigatorKey;
          return !await otherNavigatorKey.currentState.maybePop();
        },
        child: Scaffold(
          appBar: getAppBar(),
          body: Form(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    getDropDown(),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TextFormField(
                      style: textStyle,
                      controller: titleController,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          labelText: "Add Note",
                          hintText: "Note",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TextFormField(
                      style: textStyle,
                      controller: descriptionController,
                      onChanged: (value) {
                        debugPrint('Something changed in Description Text Field');
                        updateDescription();
                      },
                      decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Description",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        )),
                        Padding(padding: EdgeInsets.all(5)),
                        Expanded(
                            child: ElevatedButton(
                          child: Text("Delete"),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        )),
                      ],
                    )
                  ],
                )),
          ),
        ));
  }

  Widget getDropDown() {
    return DropdownButton(
      items: priority
          .map((selectedValue) => DropdownMenuItem(
                child: Text(selectedValue),
                value: selectedValue,
              ))
          .toList(),
      onChanged: (var newSelectedValue) {
        setState(() {
          this._selectedPriority = newSelectedValue;
          updatePriorityAsInt(_selectedPriority);
        });
      },
      value: _selectedPriority,
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  getAppBar() {
    return AppBar(
      title: Text("Add Note"),
      leading: IconButton(
          onPressed: () {
            moveToLastScreen();
          },
          icon: Icon(Icons.arrow_back_sharp)),
    );
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priorityValue = "";
    switch (value) {
      case 1:
        priorityValue = priority[0]; // 'High'
        break;
      case 2:
        priorityValue = priority[1]; // 'Low'
        break;
    }
    return priorityValue;
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id!);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    debugPrint("id ${note.id}");
    debugPrint("title ${note.title}");
    debugPrint("description ${note.description}");
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      updateTitle();
      updateDescription();
      debugPrint("Note--${note}");
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }

    moveToLastScreen();
  }
}
