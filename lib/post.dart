// ignore_for_file: constant_identifier_names

import 'package:firebase_database/firebase_database.dart';

// ignore: duplicate_ignore
class Post {
  // ignore: constant_identifier_names
  static const KEY = "key";
  static const DATE = "date";
  static const TITLE = "title";
  static const BODY = "body";

  late final int date;
  final int key;
  late final String title;
  late final String body;

  Post(
      {required this.date,
      required this.title,
      required this.body,
      required this.key});

//String get key  => _key;
//String get date  => _date;
//String get title  => _title;
//String get body  => _body;

  Post.fromSnapshot(DataSnapshot snap)
      : key = snap.value[KEY],
        body = snap.value[BODY],
        this.date = snap.value[DATE],
        this.title = snap.value[TITLE];

  Map toMap() {
    return {BODY: body, TITLE: title, DATE: date, KEY: key};
  }
}
