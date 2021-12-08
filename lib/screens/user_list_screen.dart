import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_group_project/screens/chat_screen.dart';
import 'package:mobile_app_group_project/services/firebase_service.dart';
import 'package:mobile_app_group_project/screens/profile_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseService.db
            .collection("users")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Loading..."),
            );
          } else {
            return ListView(
                //scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((e) {
                  if (e.id.toString().length == 28) {
                    return Card(
                        child: ListTile(
                            leading: Image.network(e.get("picture_url")),
                            title: Text(e.get("first_name")),
                            subtitle: Text(
                                "Joined: ${e.get("timestamp").toDate().month}/${e.get("timestamp").toDate().day}/${e.get("timestamp").toDate().year} ${e.get("timestamp").toDate().hour}:${e.get("timestamp").toDate().minute}"),
                            trailing: OutlinedButton(
                                child: const Icon(Icons.message),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (con) => ChatScreen(
                                              uid: e.id,
                                              name:
                                                  "${e.get("first_name")} ${e.get("last_name")}")));
                                }),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (con) => UserScreen(uid: e.id)));
                            }));
                  } else {
                    return Container();
                  }
                }).toList());
          }
        });
  }
}
