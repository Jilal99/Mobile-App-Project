import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';

class UserScreen extends StatefulWidget {
  final String uid;
  const UserScreen({Key? key, required String this.uid}) : super(key: key);
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: _db.collection("users").doc(widget.uid).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> documentSnapshot) {
          if (documentSnapshot.hasData) {
            var d = documentSnapshot.data!;
            return ListView(
              children: [
                Text("${d.get('first_name')} ${d.get('last_name')}",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Image.network(
                  d.get("picture_url"),
                ),
                Card(
                    child: ListTile(
                        title: Text("About ${d.get('first_name')}:",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text("${d.get('bio')}"))),
                Card(
                    child: ListTile(
                  title: const Text("Hometown:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Text("${d.get("hometown")}"),
                )),
                Card(
                    child: ListTile(
                  title: const Text("Age:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      "${DateTime.now().year - int.parse(d.get("year"))} years old"),
                )),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
