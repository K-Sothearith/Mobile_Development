import 'package:flutter/material.dart';

void main () {
  runApp (MaterialApp(
    home: Container(
      margin: EdgeInsets.all(50),
      padding: EdgeInsets.all(40),
      color: Colors.blue[300],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blue[600]
        ),
        child: Center(
          child: Text(
            'CADT STUDENTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              decoration: TextDecoration.none
            ),
          )
        ),
      ),
    ),
  )
  );
}
