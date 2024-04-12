import 'package:flutter/material.dart';

import 'login_page.dart';

Widget textField({required String labelText}) {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      labelText: labelText,
      // focusedBorder:
    ),
  );
}

Widget buttons(BuildContext context,
    {required String label, required void Function() onPressed}) {
  return Container(
    margin: const EdgeInsets.only(left: 60, right: 60),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.teal,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.normal),
      ),
    ),
  );
}
