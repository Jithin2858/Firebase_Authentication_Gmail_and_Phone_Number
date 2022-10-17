import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task2/main.dart';

import 'home_page.dart';
import 'login_page.dart';

class AuthService{
  //1. handleAuthState()
  handleAuthState(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,snapshot){
      if(snapshot.hasData){
        return HomePage();
      }else{
        return const LoginPage();
      }
    });
  }
  //2.signInWithGoogle()
  signInWithGoogle() async{
    //Trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>["email"]).signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    //Create a new Credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    //Once signed in,return the User Credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  //3. signOut()
  signOut(){
    FirebaseAuth.instance.signOut();
  }

}