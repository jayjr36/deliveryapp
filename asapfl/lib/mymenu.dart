import 'dart:convert';

import './foods_model.dart';

import './deliverypoint.dart';
import 'package:flutter/material.dart';
import './foods_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({super.key});

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myList = context.watch<FoodsProvider>().myList;
    List<Foods> foods = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY ORDER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              placeOrder(myList);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const deliveryPoint()));
            },
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 9, 112, 13),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            ),
            child: const Text(
              'CONFIRM ORDER',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              
              future: initialData(),
              builder: (context, snapshot) {
                if(snapshot.data != null){}
                var fooddata = snapshot.data as List<Foods>;
                return ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (_, index) {
                      final currentFood = myList[index];
                      return Card(
                        key: ValueKey(currentFood.title),
                        elevation: 4,
                        child: ListTile(
                          title: Text(fooddata[index].title.toString()),
                          subtitle: Text(fooddata[index].duration.toString()),
                          trailing: TextButton(
                              onPressed: () {
                                context
                                    .read<FoodsProvider>()
                                    .removeFromList(currentFood);
                              },
                              child: const Text(
                                'Remove',
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                      );
                    });
                    
              },
            ),
          ),
        ],
      ),
    );
  }

  void placeOrder(
    foodorder,
  ) async {
    final uid = (FirebaseAuth.instance.currentUser)!.uid;
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("orders");

    Map<String, dynamic> userdata = {
      "foodorder": foodorder,
    };
    reference.add(userdata);
  }
}
