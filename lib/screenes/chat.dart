import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterappchat/widget/message/message.dart';
import 'package:flutterappchat/widget/message/new_message.dart';
class ChatScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=>ChatScreenState();
}
class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
            title: Text('مركز الكلاوات يرحب بكم',textAlign: TextAlign.center),
             actions: [
               DropdownButton(
                 underline: Container(),
               icon: Icon(Icons.more_vert),
               items: [
                 DropdownMenuItem(
                     child: new Row(
                   children: [
                     Icon(Icons.exit_to_app),
                     SizedBox(width: 6,),
                     Text('تسجيل الخروج',style: TextStyle(color: Colors.white),)
                   ],
                 ),

                   value:'logout',
                 )
               ],
                 onChanged: (identityValue){
if (identityValue=='logout')
  FirebaseAuth.instance.signOut();
                 },
             ) ],
            ),

            body:Container(
              child: Column(
                children: [
                  Expanded(
                      child: new Message()
                  ),
            new NewMessage()
                ],
              ),
            )
      ,
       );
  }
}