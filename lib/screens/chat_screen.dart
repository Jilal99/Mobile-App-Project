import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_group_project/services/firebase_service.dart';
import 'package:bubble/bubble.dart';

class ChatScreen extends StatefulWidget {
  final String uid;
  final String name;
  const ChatScreen(
      {Key? key, required String this.uid, required String this.name})
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _messageController;
  late ScrollController _listScrollController;
  String? myuid = FirebaseService.auth.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseService.db
                        .collection("chats")
                        .where("conversation_id",
                            isEqualTo: myuid!.compareTo(widget.uid) < 0
                                ? "${myuid}_${widget.uid}"
                                : "${widget.uid}_${myuid}")
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
                            reverse: true,
                            shrinkWrap: true,
                            controller: _listScrollController,
                            children: snapshot.data!.docs.map((e) {
                              if (e.get("owner_id") == myuid) {
                                return Column(
                                  children: [
                                    Bubble(
                                        color: Colors.blue,
                                        alignment: Alignment.topRight,
                                        nip: BubbleNip.rightTop,
                                        child: Text(e.get("message"),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white))),
                                    const SizedBox(height: 10.0)
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    Bubble(
                                        color: Colors.blue,
                                        alignment: Alignment.topLeft,
                                        nip: BubbleNip.leftTop,
                                        child: Text(e.get("message"),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white))),
                                    const SizedBox(height: 10.0)
                                  ],
                                );
                              }
                            }).toList());
                      }
                    })),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      autocorrect: false,
                      controller: _messageController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          hintText: 'Enter Message...'),
                    )),
                    IconButton(
                      onPressed: () {
                        sendMessage(_messageController.text);
                      },
                      icon: Icon(Icons.send),
                    )
                  ],
                ))
          ],
        ),
        appBar: AppBar(
          title: Text(widget.name),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: 'Go Back',
              icon: const Icon(Icons.arrow_back),
            )
          ],
        ));
  }

  void sendMessage(String message) {
    if (message.trim() != '') {
      _messageController.clear();
      _listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
      String conversationid = myuid!.compareTo(widget.uid) < 0
          ? "${myuid}_${widget.uid}"
          : "${widget.uid}_${myuid}";
      String chatid;
      var ref = FirebaseService.db.collection("chats").doc();
      chatid = ref.id;
      ref
          .set({
            "timestamp": DateTime.now(),
            "message": message,
            "owner_id": myuid,
            "conversation_id": conversationid
          })
          .then((value) => null)
          .catchError((error) => print("$error"));

      FirebaseService.db
          .collection("conversations")
          .doc(conversationid)
          .set({"most_recent": chatid})
          .then((value) => null)
          .catchError((error) => print("$error"));
    }
  }
}
