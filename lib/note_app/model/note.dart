import 'package:first_app/note_app/utils/Const.dart';

class Note {
  int? _id;

  String? _title;
  String? _description;
  String? _date;
  int _priority = 2;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[ID] = _id;
    }
    map[TITLE] = _title;
    map[DESCRIPTION] = _description;
    map[DATE] = _date;
    map[PRIORITY] = _priority;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map[ID];
    this._title = map[TITLE];
    this._description = map[DESCRIPTION];
    this._date = map[DATE];
    this._priority = map[PRIORITY];
  }

  int? get id => _id;

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String? get date => _date;

  set date(String? value) {
    _date = value;
  }

  int get priority => _priority;

  set priority(int value) => _priority = value;
}
