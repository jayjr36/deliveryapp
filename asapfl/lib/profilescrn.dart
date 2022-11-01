import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './user_model.dart';


class profile extends StatefulWidget {
  profile({required Key key, required this.user, required this.uid}):super(key: key);
  final UserModel user;
  String? uid;

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
    getuserid() {
     final User? user = FirebaseAuth.instance.currentUser;
     final uid = user?.uid;
   }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight:h*0.1,
         title:const Center(child:Text('PROFILE',
         style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
         ),) ,),
      ),

      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          final user = snapshot.data;
          final uid = getuserid(); //get userid

             return FutureBuilder<DocumentSnapshot>(
               future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
               builder: (context, snapshot) {
                 if(snapshot.hasError){
                   return Text('Something went wrong');
                 }
                 if(snapshot.hasData && !snapshot.data!.exists){
                   return Text('Documents does not exist');
                 }
                 if(snapshot.connectionState == ConnectionState.done ) {
                   Map<String, dynamic> data = snapshot.data!.data() as Map<
                       String,
                       dynamic>;

                   return Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 50),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,

                       children: [
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 60),
                           height: h * 0.2,
                           child: const Icon(Icons.account_circle,
                             size: 200,
                           ),

                         ),
                         const SizedBox(height: 45,),
                         const Text('Name',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                           ),),

                         const SizedBox(height: 5,),
                          Text("${data['username']}",
                           style: const TextStyle(
                             fontWeight: FontWeight.normal,
                             fontSize: 18,
                           ),),

                         const SizedBox(height: 15,),
                         const Text('Phone',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                           ),),
                         const SizedBox(height: 5,),
                         Text("${data['phone']}",
                           style: const TextStyle(
                             fontWeight: FontWeight.normal,
                             fontSize: 18,
                           ),),

                         const SizedBox(height: 15,),
                         const Text('Email',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                           ),),
                         const SizedBox(height: 5,),
                         Text("${data['email']}",
                           style: const TextStyle(
                             fontWeight: FontWeight.normal,
                             fontSize: 18,
                           ),)
                       ],
                     ),
                   );
                 }throw(const Text("error"));
               }
             );

        }
      ),
    );
  }
}

