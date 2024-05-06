import 'package:flutter/material.dart';
import 'package:simple_grocery/features/home/ui/home.dart';
import 'package:simple_grocery/features/routes/routes.dart';
import 'package:simple_grocery/utils/color_constants.dart';

import 'login/login_page.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.teal.shade50),
        child: Column(
          children: <Widget>[
            Image.asset('assets/welcome.png'),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: const Text(
                    'Your go-to',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'destination',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.red.shade400),
                ),
              ],
            ),
            const Text(
              'for fresh groceries at',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              'your fingertips',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.red.shade500),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(left: 60, right: 60),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Routes()),
                      (route) => false);
                },
                child: const Text(
                  'Start shopping now! -->',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
