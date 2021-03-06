import 'package:mobile_app_group_project/post_service.dart';
import 'package:mobile_app_group_project/post.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_group_project/screens/home_screen.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = GlobalKey();
  Post? post;
  String title = '';
  String body = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Post Title", border: OutlineInputBorder()),
                  onChanged: (value) {
                    title = value;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Title field can't be empty";
                    } else if (val.length > 16) {
                      return "Title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Post Body", border: OutlineInputBorder()),
                  onChanged: (value) {
                    body = value;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Body field can't be empty";
                    }
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertPost();
          //Navigator.of(context).pop();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Icon(
          Icons.post_add_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "Add a Post",
      ),
    );
  }

  void insertPost() {
    final FormState? form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      form.reset();
      post = Post(
          date: DateTime.now().millisecondsSinceEpoch,
          title: title,
          body: body,
          key: DateTime.now().millisecondsSinceEpoch);
      PostService postService = PostService(post!.toMap());
      postService.addPost();
    }
  }
}
