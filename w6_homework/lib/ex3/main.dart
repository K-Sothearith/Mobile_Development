import 'package:flutter/material.dart';

const String dartImage = 'assets/ex3/dart.png';
const String firebaseImage = 'assets/ex3/firebase.png';
const String flutterImage = 'assets/ex3/flutter.png';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Products', style: TextStyle(fontSize: 30)),
          centerTitle: false,
        ),
        body: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductCard(product: Product.dart),
                ProductCard(product: Product.flutter),
                ProductCard(product: Product.firebase)
              ],
            )
          ),
        ),
      ),
    ),
  );
}

// Each enum value stores the information for one product.
enum Product {
  dart('Dart', 'The best object language', dartImage),
  flutter('Flutter', 'The best mobile widget library', flutterImage),
  firebase('Firebase', 'The best cloud database', firebaseImage);

  final String title;
  final String description;
  final String image;

  const Product(this.title, this.description, this.image);
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.image,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(product.title, style: TextStyle(fontSize: 28)),
            const SizedBox(height: 4),
            Text(product.description, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
