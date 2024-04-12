import 'package:flutter/material.dart';

import '../login/login_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 150),
              child: const Text(
                'Sign-up',
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
                  textField(labelText: 'username'),
                  const SizedBox(
                    height: 15,
                  ),
                  textField(labelText: 'email-address'),
                  const SizedBox(
                    height: 25,
                  ),
                  textField(labelText: 'password'),
                  const SizedBox(
                    height: 15,
                  ),
                  textField(labelText: 're-enter password'),
                  const SizedBox(
                    height: 15,
                  ),
                  buttons(context, label: 'Sign-up', onPressed: () {
                    print('registered success');
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 200),
                    child: const Text('Not a member! Sign-up'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
