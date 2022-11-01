// ignore_for_file: camel_case_types, body_might_complete_normally_nullable



import './login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import './user_model.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController phonectrl = TextEditingController();
  TextEditingController pwordctrl = TextEditingController();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 0.2),
          child: AppBar(
            toolbarHeight: h * 0.2,
            title: Center(
              child: Image.asset(
                'assets/asapreg.png',
                fit: BoxFit.fill,
              ),
            ),
            backgroundColor: Colors.white,
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.green,
            
            
          ),
          height: h * 0.75,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create an account',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      fontFamily: "Calibri",
                    )),
                const SizedBox(height: 15),
                TextFormField(
                  controller: namectrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Name',
                    hintText: 'Full name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("Username cannot be Empty");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid name(Min. 3 Character)");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    namectrl.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailctrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'youname@yahoo.com',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
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
                const SizedBox(height: 15),
                TextFormField(
                  controller: phonectrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '0*********',
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp('^:[0][0-9]{10}');
                    if (value!.isEmpty) {
                      return ("Phone number can not be blank");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter valid phone number");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phonectrl.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: pwordctrl,
                  obscureText: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(Min. 6 Character)");
                    }
                  },
                  onSaved: (value) {
                    pwordctrl.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: pwordctrl,
                  obscureText: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Confirm password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(Min. 6 Character)");
                    }
                  },
                  onSaved: (value) {
                    pwordctrl.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                Center(
                  child: TextButton(
                      onPressed: () async {
                        /*register action btn */
                        signUp(emailctrl.text, pwordctrl.text,phonectrl.text,namectrl.text);

                        /*
                        Future<User?> createUser(String username,String email ,String password,String phone) async{
                          final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailctrl.text, password: pwordctrl.text);
                          FirebaseFirestore.instance
                            .collection("users")
                          .doc(user.user!.uid)
                          .set({'username':username, 'email':email, 'phone': phone})
                          .catchError((e){
                            Fluttertoast.showToast(msg: e!.message);
                          });


                          Fluttertoast.showToast(msg: "Account created successfully :) ");

                          Navigator.pushAndRemoveUntil((context),
                              MaterialPageRoute(builder: (context) =>const login()), (route) => false);
                        }*/
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 2, 54, 4)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(left: 50, right: 50))),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => {



                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const login();
                        }))
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel(uid: user!.uid);

    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.username = namectrl.text;
    userModel.phone = phonectrl.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => login()), (route) => false);
  }

  void signUp(String email, String password, String phone, String username) async {
    try {
      createUser(namectrl.text, phonectrl.text, emailctrl.text, pwordctrl.text);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }

  void createUser(String name, String phone, String email, String password) async {
    CollectionReference reference =
    FirebaseFirestore.instance.collection("Users");

    Map<String, String> userdata = {
      "Name": name,
      "Phone": phone,
    };
    reference.add(userdata);
  }

}
