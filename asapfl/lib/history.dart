import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
class PreviousOrders extends StatefulWidget {
  const PreviousOrders({super.key});

  @override
  State<PreviousOrders> createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {

  @override
  Widget build(BuildContext context) {
       double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * 0.15,
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 30, top: 80),
                child: const Text(
                  'PREVIOUS ORDERS',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),

      body: StreamBuilder(
        stream: getUsersOrderStreamSnapshot(context),
         builder: (context, AsyncSnapshot snapshot) {
           String uid = (FirebaseAuth.instance.currentUser)!.uid;
           if(!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);


           return ListView.builder(

             itemCount: snapshot.data!.docs.length,
               itemBuilder: (context,index) =>
           buildFoodcard(context,snapshot.data.document[index]));
         }
    ),
    );
  }
  Stream <QuerySnapshot> getUsersOrderStreamSnapshot(BuildContext context) async*{
    final uid = await Provider.of(context, listen: false).auth.getCurrentUID();

    yield*FirebaseFirestore.instance.collection("users").doc(uid).collection("orders").snapshots();
  }
  Widget buildFoodcard (BuildContext context, DocumentSnapshot order){

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Row(
              children: [

                Text(order["name"],
                  style: const TextStyle(fontSize: 30.0),
                ),
                Text(order["foodorder"],
                style: const TextStyle(fontSize: 30.0),
                ),

                Text(order["location"],
                  style: const TextStyle(fontSize: 30.0),
                ),

                Text(order["phone"],
                  style: const TextStyle(fontSize: 30.0),
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}