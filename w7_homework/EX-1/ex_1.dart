import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom buttons"),
        ),
        body: Center(
          child: SizedBox(
                width: 400,
                height: 100,
                child: ElevatedButton(
                    onPressed: () => {},
                    child: const Center(
                      child: Text("Not Selected"),
                    )),
              ),
        ),
      ),
    ));
