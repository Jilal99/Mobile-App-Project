import 'package:mobile_app_group_project/post_service.dart';
import 'package:mobile_app_group_project/post.dart';
import 'package:mobile_app_group_project/forum_home.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  final Post post;

  EditPost(this.post);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("edit post"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.post.title,
                  decoration: InputDecoration(
                      labelText: "Post tilte", border: OutlineInputBorder()),
                  onSaved: (val) => widget.post.title = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "title field cant be empty";
                    } else if (val.length > 16) {
                      return "title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.post.body,
                  decoration: InputDecoration(
                      labelText: "Post body", border: OutlineInputBorder()),
                  onSaved: (val) => widget.post.body = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "body field cant be empty";
                    }
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertPost();
//        Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "exit a post",
      ),
    );
  }

  void insertPost() {
    final FormState? form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      form.reset();
      widget.post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(widget.post.toMap());
      postService.updatePost();
    }
  }
}
