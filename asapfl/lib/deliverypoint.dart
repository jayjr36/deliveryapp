import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './home.dart';

class deliveryPoint extends StatefulWidget {
  const deliveryPoint({super.key});

  @override
  State<deliveryPoint> createState() => _deliveryPointState();
}

class _deliveryPointState extends State<deliveryPoint> {
  TextEditingController addressctrl = TextEditingController();
  TextEditingController phonectrl = TextEditingController();
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
                  'DELIVERY POINT',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 39),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              maxLines: 5,
              controller: addressctrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Your location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSaved: (value) {
                addressctrl.text = value!;
              },
              textInputAction: TextInputAction.next,
              autofocus: false,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: phonectrl,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSaved: (value) {
                phonectrl.text = value!;
              },
              textInputAction: TextInputAction.next,
              autofocus: false,
            ),
            const SizedBox(height: 25),
            const Text('Delivery prices are \n500Tsh for foods picked at the university\'s canteen \nand 1000Tsh for foods from restaurants',
            style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 18),),
         
         
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                addlocation(addressctrl.text, phonectrl.text);
                Fluttertoast.showToast(msg: "Your order has been received");

             Navigator.pushAndRemoveUntil((context),
              MaterialPageRoute(builder: (context) => Home()), (route) => false);

                /**SEND LOCATION DETAILS TO FIREBASE
                 * AND ORDER 
                */
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              ),
              child: const Text(
                'SEND',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addlocation(String location, String phone,) async {
    final uid = (FirebaseAuth.instance.currentUser)!.uid;
    CollectionReference reference =
    FirebaseFirestore.instance.collection("users").doc(uid).collection("orders");

    Map<String, String> userdata = {
      "location": location,
      "phone": phone,
    };
    reference.add(userdata);
  }
}


