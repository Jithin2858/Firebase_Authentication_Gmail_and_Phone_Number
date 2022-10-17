import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/verify_code.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading= false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),

            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+91 9605 4312 74'
              ),
            ),
            SizedBox(height: 30,),
        GestureDetector(
          onTap: (){
            //AuthService.phoneverification method
            setState((){
              loading=true;
            });
            auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                verificationCompleted: (_){
                  setState((){
                    loading=false;
                  });
                },
                verificationFailed: (e){
                  setState((){
                    loading=false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Verification Failed"),
                  ));
                },
                codeSent: (String verificationId, int? token){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=> VerifyCodeScreen(verificationId:verificationId)));
                  setState((){
                    loading=false;
                  });
                },
                codeAutoRetrievalTimeout: (e){
                  setState((){
                    loading=false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Verification Failed"),
                  ));
                });
          },
          child: Container(
              padding: EdgeInsets.only(top:20,bottom: 20,left:20,right:20),
              child : Text(
                "Sign-In With Phone Number",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange
              )),
        ),
          ],
        ),
      ),
    );
  }
}
