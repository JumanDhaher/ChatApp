import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../widgets/messages.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for IOS
  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions(); 
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat...'),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('LogOut')
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (item) {
                if (item == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[Expanded(child: Messaages()), NewMessage()],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/ZYzYPwBmiJhlteT9Zxy4/messages')
              .add({'text': 'this added'});
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}

/*
 Firestore.instance
              .collection('chats/ZYzYPwBmiJhlteT9Zxy4/messages')
              .snapshots()
              .listen((data) {
            data.documents.forEach((element) {
              print(element['text']);
            });
          });


 StreamBuilder(
        stream: Firestore.instance
            .collection('chats/ZYzYPwBmiJhlteT9Zxy4/messages')
            .snapshots(),
        builder: (ctx, streamSnapShot) {
          if (streamSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapShot.data.documents;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, indx) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(documents[indx]['text']),
                  ));
        },
      )
 */
