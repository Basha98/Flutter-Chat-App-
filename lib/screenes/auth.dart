import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappchat/widget/authForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
 bool _isloading=false;

  void _submitAuthScreen(String email,String username,String password,bool islogin,BuildContext ctx,File imag)async
  {
  try{

    setState(() {
      _isloading=true;
    });

    var authResult;
    if(islogin)
    {
      authResult=await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);
    }

    else
      {
        authResult=await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password);

      final ref=await  FirebaseStorage.instance.ref().child('user_image').child(authResult.user.uid+'.jpg');
       await ref.putFile(imag);
       final url=await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('Users').
       doc(authResult.user.uid )
      .set({
            'username':username,
         'password':password,
        'image_url':url
      });

      }
 }on FirebaseAuthException catch(e){
    String msg='reeor ocure';
    if(e.code=='weak-password')
      msg='the password provided is too weak.';
    else if(e.code=='email-already-in-user')
      msg='the account already exists for that email.';
    else if(e.code=='user-not-found')
      msg='No user found for that email.';
    else if(e.code=='wrong-password')
      msg='Wrong Password provided for that user.';
Scaffold.of(ctx).showSnackBar(SnackBar(
  content: Text(msg),
  backgroundColor: Theme.of(ctx).primaryColor,)

);  setState(() {
      _isloading=false;
    });
  }

  catch(e)
    {
      print(e);
      setState(() {
        _isloading=true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new AuthForm(_submitAuthScreen,_isloading),
    );
  }
}