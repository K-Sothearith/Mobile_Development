import 'package:flutter/material.dart';

void main () {
  runApp(
    MaterialApp(
      home: Container(
        margin: EdgeInsets.all(50),
        padding: EdgeInsets.all(20),
        color: Colors.grey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.blue[100]
              ),
              child: Center(
                child: Text(
                  'OOP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.blue[300]
              ),
              child: Center(
                child: Text(
                  'DART',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [Colors.blue[300]!, Colors.blue[600]!]
                )
              ),
              child: Center(
                child: Text(
                  'FLUTTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
            )
          ],
        )
      )
    )
  );
}