import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  static const String id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration: kTextFieldInputDecoration.copyWith(hintText: 'Enter your email')
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      style: TextStyle(color: Colors.black),
                      obscureText: true,
                      textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      password = value;
                    },
                    decoration: kTextFieldInputDecoration.copyWith(hintText: 'Enter your password')
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(color: Colors.lightBlueAccent, text: 'Log In',
                      onPressed: ()async{
                    final progress = ProgressHUD.of(context);
                    progress.showWithText('Please Wait...');
                        try{
                          final existingUser =await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(existingUser != null){

                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          progress.dismiss();
                        }catch(e){
                          print(e);
                        }
                      }),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
