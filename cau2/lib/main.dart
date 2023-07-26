import 'package:flutter/material.dart';

// Product model class (you can define your product class accordingly)
class Product {
  String name;
  String imageUrl;

  Product({required this.name, required this.imageUrl});
}

class ProductListScreen extends StatelessWidget {
  // Sample list of products (you can replace this with your own data)
  final List<Product> products = [
    Product(
      name: 'Bánh Pancake',
      imageUrl:
      'https://i.pinimg.com/564x/d9/2f/96/d92f96798e77c1973c6998c331716ba0.jpg', // Replace with actual image URL
    ),
    Product(
      name: 'Bánh cuộn kem',
      imageUrl:
      'https://i.pinimg.com/564x/17/ea/94/17ea94cb3b36d61e3e0472541fed33fd.jpg', // Replace with actual image URL
    ),
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            leading: Image.network(products[index].imageUrl),
            onTap: () {
              // Navigate to the product detail screen when a product is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('Tên: ${product.name}'),
            Image.network(
              product.imageUrl,
              //height: 100,
              //width: 900,
            ),
            Text('Tên: ${product.name}'),
            // Add more details about the product here
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProductListScreen(),
  ));
}
