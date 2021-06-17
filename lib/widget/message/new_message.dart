import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class NewMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>new NewMessageState();

}
class NewMessageState extends State<NewMessage>{
  final _controler=TextEditingController();
  String txt;
  String _entryMessage='';

  _SendMessage() async{
    final user=await FirebaseAuth.instance.currentUser;
final userData=await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chat')
        .add({
      'text':_entryMessage,
      'time':Timestamp.now(),
      'username':userData['username'],
      'userid':user.uid,
      'user_image':userData['image_url']
    });
    _controler.clear();
    setState(() {
      _entryMessage='';
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(

      margin: EdgeInsets.only(top: 8,left:22),
      padding:EdgeInsets.all(8),
      child:Row(
        children: [
          Expanded(
              child: TextField(textDirection: TextDirection.rtl,
            controller: _controler,
               style:  TextStyle(color: Colors.white,),
                decoration: InputDecoration(hintText: 'Send a message...',
                   hintStyle: TextStyle(color:Theme.of(context).primaryColor),

                   enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide( color:Theme.of(context).primaryColor)
                    ),
                ),
              onChanged: (val){
              setState(() {
               _entryMessage=val;
             });
               },
        )
   ,
          )
          ,
          Expanded(child: IconButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Colors.grey,
            icon: Icon(Icons.send),
            onPressed: _entryMessage.trim().isEmpty?null:_SendMessage,
          ))
        ],
      ) ,
    );

  }
}

//   TextFormField(textDirection: TextDirection.rtl,
//          style:  TextStyle(color: Colors.white,),
//                key: ValueKey('txt'),
//                validator: null,
//                onSaved: (val)=>txt=val,
//                decoration: InputDecoration(hintText: "Send message.... ",hintStyle: TextStyle(color:Theme.of(context).primaryColor)),
//              )