import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterappchat/screenes/auth.dart';
import 'package:flutterappchat/screenes/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterappchat/screenes/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'كلاوشات',
        theme: ThemeData(
          canvasColor: Colors.black54,
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.cyan,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),

        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx,snap){
            if(snap.connectionState==ConnectionState.waiting)
              return SplashScreen();
            if(snap.hasData)
              return ChatScreen();
            else
              return AuthScreen();
          },)

        );


  }
}
