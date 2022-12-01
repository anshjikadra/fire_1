import 'package:fire_1/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {


//=================google and firebase sigbin krva mate=====================

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//================signin che ke nay ee cheack krva mate============
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return dasboard();
          },
        ));
      } else {
        print("not login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fire_base_1", style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                signInWithGoogle().then((value) {
                  print(value);
                  if (value != null) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return dasboard();
                      },
                    ));
                  } else {
                    print("Not login");
                  }
                });
              },
              child: Text("Data")),
        ));
  }
}
