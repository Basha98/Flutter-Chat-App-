import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterappchat/widget/message/message_bubble.dart';
class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('time',descending: true).snapshots(),
      builder: (ctx, snapshot)
      {
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return  CircularProgressIndicator();
          }
        final doc = snapshot.data.docs;
        final user= FirebaseAuth.instance.currentUser;
        return ListView.builder(
          itemCount: doc.length,
          itemBuilder: (ctx, index) {
            return new MessageBubble(
                doc[index]['text'],
                doc[index]['username'],
                doc[index]['user_image'],
                doc[index]['userid']==user.uid?true:false,
                key: ValueKey(doc[index].documentID)
            );

          },
       reverse: true, );
      },
    );
  }
}
