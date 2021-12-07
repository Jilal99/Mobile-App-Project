// ignore: file_names
// ignore: file_names
//import 'package:firebase_course/models/post.dart';
import 'package:firebase_database/firebase_database.dart';

class PostService {
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference _databaseReference;
  late Map post;

  PostService(Map map) {
    this.post = map;
  }

  //PostService(this.post);

  addPost() {
//    this is going to give a reference to the posts node
    database.reference().child(nodeName).push().set(post);
  }

  deletePost() {
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost() {
    database.reference().child('$nodeName/${post['key']}').update(
        {"title": post['title'], "body": post['body'], "date": post['date']});
  }
}
