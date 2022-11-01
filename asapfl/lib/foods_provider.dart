import 'dart:convert';
import 'dart:io';

import './foods_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@override
void initState() {
  initialData();
}

Future<List<Foods>> initialData() async {
  var mydata = await rootBundle.loadString('assets/foodlist.json');
  var jsonData = jsonDecode(mydata) as List<dynamic>;
  return jsonData.map((e) => Foods.fromJson(e)).toList();
  /*return jsonData.keys.map<Foods>((code) {
    final json = jsonData[code];
    final newjson = json..addAll({'code': code.toLowerCase()});
    return newjson.toList();
    // Foods.fromJson(newjson);
  });*/
}

class FoodsProvider with ChangeNotifier {
  FoodsProvider() {
    initialData().then((e) {
      _foods = foods;
      notifyListeners();
    });
  }

  List<Foods> _foods = [];
  List<Foods> get foods => _foods;

  final List<Foods> _myList = [];
  List<Foods> get myList => _myList;

  void addToList(Foods foods) {
    _myList.add(foods);
    notifyListeners();
  }

  void removeFromList(Foods foods) {
    _myList.remove(foods);
    notifyListeners();
  }

  Future<String> getCurrentUID() async {
    return (await FirebaseAuth.instance.currentUser!.uid);
  }

  
}
