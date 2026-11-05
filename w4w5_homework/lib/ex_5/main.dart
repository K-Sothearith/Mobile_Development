import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 72,
                color: Colors.deepOrangeAccent,
                child: const Center(
                  child: Text(
                    'Welcome !',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'My hobbies',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.orange[200],
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: const Center(
                                child: Text(
                                  'Soccer',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange[800],
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: const Center(
                                child: Text(
                                  'Flutter',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 72,
                color: Colors.deepOrangeAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
