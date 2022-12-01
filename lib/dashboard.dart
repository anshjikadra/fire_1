import 'package:fire_1/first.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class dasboard extends StatefulWidget {

  @override
  State<dasboard> createState() => _dasboardState();
}

class _dasboardState extends State<dasboard> {
  User? user;

  @override
  void initState() {
    super.initState();
     user = FirebaseAuth.instance.currentUser;
    if(user==null)
      {
        print("Not Login");
      }
    else
      {
        print(user!.email);
        print(user!.displayName);
        print(user!.uid);

      }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        leading: IconButton(onPressed: () async {
          await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return first();
              },));


         print("Signout");


        }, icon: Icon(Icons.logout)),
      ),
      body: Column(
        children: [
          Text("${user!.email}"),
          Text("${user!.displayName}"),
          Text("${user!.uid}"),
        ],
      ),
    );
  }


}
