import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class recovery extends StatefulWidget {
  const recovery({super.key});

  @override
  State<recovery> createState() => _recoveryState();
}

class _recoveryState extends State<recovery> {
  TextEditingController emailctrl = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: h*0.06,
        
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Reset password',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Colors.black),
              ),
              const Text(
                "Enter the email associated with your account\nand we\'ll send an email with instructions to\nreset your password",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black),
              ),

              const SizedBox(height: 30,),
              TextFormField(
                controller: emailctrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  
                  ),
                  focusColor: Colors.green,
                  hintText:'Email',
                  
                ),
                validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailctrl.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  autofocus: false,
              ),
              const SizedBox(height: 15,),

              ElevatedButton(onPressed: (){
                /**send recovery email */
               resetpassword(emailctrl.text);
                
                Fluttertoast.showToast(msg: "Password Reset email link is been sent");
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                shadowColor: Colors.green,
              ), child: const Text('SEND',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetpassword(String email) async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailctrl.text);
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: "Error: ${e}");
    }
  }
}
