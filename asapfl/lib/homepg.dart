import 'package:firebase_auth/firebase_auth.dart';
import './profilescrn.dart';

import './food_menu.dart';
import 'package:flutter/material.dart';

class Homepg extends StatefulWidget {
  const Homepg({super.key});

  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  get user => FirebaseAuth.instance.currentUser;

  get key => key;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * 0.15,
        backgroundColor: Colors.green,
        title: Row(
          
          children: [
            IconButton(
              onPressed: () {

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  profile(uid: 'uid', user: user, key: key,)));
                /**route to user's profile */
              },
              icon: const Icon(
                Icons.account_circle,
                size: 50,
                color: Colors.black,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 70, top: 30),
                child:  const Center(
                  child: Image(
                    image: AssetImage("assets/asap.png"),
                    fit: BoxFit.contain,
                  ),
                )),
          ],
        ),
      ),
      body: SafeArea(
          child: Center(
              child: SizedBox(
        height: h * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left:20.0, top: 5, right: 20),
              child: Center(
                child: Text(
                  'Your next meal is a just a \n           click away.',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'pacifico',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
               SizedBox(
                height: 200,
                 child: ListView(
                  scrollDirection: Axis.horizontal,
                  
              children: [
                  SizedBox(
                    width: 300,
                    
                    child: Image.asset(
                      'assets/one.png',
                      fit: BoxFit.contain,
                      
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    
                    child: Image.asset(
                      'assets/two.png',
                      fit: BoxFit.contain,
                      
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    
                    child: Image.asset(
                      'assets/three.png',
                      fit: BoxFit.contain,
                      
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    
                    child: Image.asset(
                      'assets/four.png',
                      fit: BoxFit.contain,
                      
                    ),
                  ),
              ],
            ),
               ),
               const SizedBox(height: 30,),
            const Text(
              'Click on the button below\n        to view our menu',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Times new roman'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const FoodMenu()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 21, 65, 22))))),
              child: const Text(
                'VIEW MENU',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      )
      )
      )
      );
    
  }
}