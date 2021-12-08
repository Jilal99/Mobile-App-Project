import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_group_project/screens/chat_screen.dart';
import 'package:mobile_app_group_project/services/firebase_service.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({Key? key}) : super(key: key);
  @override
  _ConversationListScreenState createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  Widget build(BuildContext context) {
    String firstName = "";
    return Column(children: [
      const SizedBox(height: 10.0),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseService.db.collection("conversations").snapshots(),
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
                    String? myuid = FirebaseService.auth.currentUser!.uid;
                    String otherid;
                    String convoid = e.id.toString();
                    if (convoid.length == 57 &&
                        (convoid.substring(0, 28) == myuid ||
                            convoid.substring(29, 57) == myuid)) {
                      if (convoid.substring(0, 28) != myuid) {
                        otherid = convoid.substring(0, 28);
                      } else {
                        otherid = convoid.substring(29, 57);
                      }
                      return Card(
                          child: ListTile(
                              leading: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseService.db
                                      .collection("users")
                                      .doc(otherid)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          documentSnapshot) {
                                    if (documentSnapshot.hasData) {
                                      return Image.network(documentSnapshot
                                          .data!
                                          .get("picture_url"));
                                    } else {
                                      return Container(width: 1);
                                    }
                                  }),
                              title: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseService.db
                                      .collection("users")
                                      .doc(otherid)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          documentSnapshot) {
                                    if (documentSnapshot.hasData) {
                                      firstName = documentSnapshot.data!
                                          .get("first_name");
                                      return Text(documentSnapshot.data!
                                          .get("first_name"));
                                    } else {
                                      return Container(width: 1);
                                    }
                                  }),
                              subtitle: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseService.db
                                      .collection("chats")
                                      .doc(e.get("most_recent"))
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          documentSnapshot) {
                                    if (documentSnapshot.hasData) {
                                      return Text(
                                          "${documentSnapshot.data!.get("owner_id") == myuid ? "You" : firstName} said: ${documentSnapshot.data!.get("message")}");
                                    } else {
                                      return Container(width: 1);
                                    }
                                  }),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (con) => ChatScreen(
                                            uid: otherid, name: firstName)));
                              }));
                    } else {
                      return Container();
                    }
                  }).toList());
            }
          })
    ]);
  }
}
