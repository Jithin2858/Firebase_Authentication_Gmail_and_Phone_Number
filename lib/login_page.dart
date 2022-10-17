import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_with_phone_number.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Google Login"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: 600,
        height: 600,
        padding: EdgeInsets.only(
            left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("TASK_2",
                style: TextStyle(
                    fontSize: 15
                )),
            SizedBox(height: 10),
            Container(
              height: 192,
              width: 192,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/google.png'),
                  fit: BoxFit.fill
                )
              ),
            ),
            SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              AuthService().signInWithGoogle();
            },
           //child: const Image(width: 75, image: AssetImage('assets/google.png'))),
            child: Container(
                padding: EdgeInsets.only(top:20,bottom: 20,left:20,right:20),
                child : Text(
                  "Google Sign-IN",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange
                ),
              ),
        ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginWithPhoneNumber()
                ));
              },
              //child: const Image(width: 75, image: AssetImage('assets/google.png'))),
              child: Container(
                padding: EdgeInsets.only(top:20,bottom: 20,left:20,right:20),
                child : Text(
                  "Sign-In With Phone Number",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}