import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/home_page.dart';
import 'package:task2/login_page.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading= false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                controller: verificationCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter the 6 digit OTP'
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  //AuthService.phoneverification method
                  setState(() {
                    loading=true;
                  });
                  final credentials = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationCodeController.text.toString()
                  );
                  try{
                    await auth.signInWithCredential(credentials);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Verification Successful"),
                    ));
                  }catch(e){
                    setState(() {
                      loading=false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Verification Failed"),
                    ));
                  }
                },
                child:   Container(
                    padding: EdgeInsets.only(top:20,bottom: 20,left:20,right:20),
                    child : Text(
                      "Verify",
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
