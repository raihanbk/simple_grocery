import 'package:flutter/material.dart';

import '../signup/sign_up.dart';
import 'login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal.shade50,
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            color: Colors.teal.shade50
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 300),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      children: [
                      textField(labelText: 'email-address'),
                  const SizedBox(
                    height: 25,
                  ),
                  textField(labelText: 'password'),
                  const SizedBox(
                    height: 25,
                  ),
                  buttons(context, label: 'Login', onPressed: () {
              print('Login success');
              }),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(right: 180),
                child: const Text('Not a member! Register here'),
              ),
              buttons(context, label: 'Sign-up', onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              }),
            ],
          ),
        ),
        ],
      ),
    ),)
    ,
    );
  }
}
