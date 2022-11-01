import 'dart:io';

import 'package:asap/deliverypoint.dart';
import 'package:asap/signup.dart';

import './foods_provider.dart';
import './home.dart';
import './homepg.dart';
import './info.dart';
import './login.dart';
import './profilescrn.dart';
import './recovery.dart';
import './splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './food_menu.dart';
import './foods_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if(const bool .fromEnvironment("PRODUCTION")) {
    await _configureFirebaseAuth();
    await _configureFirebaseFirestore();
  }
  runApp(ChangeNotifierProvider<FoodsProvider>(
    child: const myApp(),
    create: (_) => FoodsProvider(),
  ));
  // ignore: prefer_const_constructors
}

Future<void> _configureFirebaseAuth() async {
    String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
    int configPort = const int.fromEnvironment("AUTH_EMU_PORT");
    var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    var host = configHost.isNotEmpty ? configHost : defaultHost;
    var port = configPort != 0 ? configPort : 9099;
    await FirebaseAuth.instance.useAuthEmulator(host, port);
    debugPrint('Using Firebase Auth emulator on: $host:$port');
  }
  
  

  Future <void> _configureFirebaseFirestore() async{
    String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
    int configPort = const int.fromEnvironment("DB_EMU_PORT");
    var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    var host = configHost.isNotEmpty ? configHost : defaultHost;
    var port = configPort != 0 ? configPort : 8080;
    
    FirebaseFirestore.instance.settings = Settings(
      host: '$host:$port',
      sslEnabled: false,
      persistenceEnabled: false,
    );
    debugPrint('Using firebase firestore emulator on: $host:$port');
  }



class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // ignore: prefer_const_constructors
      home: FoodMenu(),
    );
  }
}
