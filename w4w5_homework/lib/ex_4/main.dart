import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 920,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 100),
                Container(height: 400, color: Colors.blue[600]),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(color: Colors.green[700]),
                      ),
                      Container(width: 100, color: Colors.pink[300]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: Container(color: Colors.amber)),
                      SizedBox(width: 20),
                      Expanded(child: Container(color: Colors.amber)),
                      SizedBox(width: 20),
                      Expanded(child: Container(color: Colors.amber)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(color: Colors.pink[300]),
                ),
              ],
            ),
          ),
        ),
      ),
    )
  );
}
