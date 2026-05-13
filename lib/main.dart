import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<Map<String, String>> favoriteProducts = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

//================ HOME SCREEN =================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),

      body: Center(
        child: ElevatedButton(
          child: const Text("Go To Details"),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DetailScreen()),
            );
          },
        ),
      ),
    );
  }
}

//================ DETAIL SCREEN =================

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Screen")),

      body: Center(
        child: ElevatedButton(
          child: const Text("Go To Product List"),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductListScreen()),
            );
          },
        ),
      ),
    );
  }
}

//================ PRODUCT LIST =================

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Map<String, String>> products = [
    {"name": "Laptop", "image": "lib/assets/images/laptop.jpg"},

    {"name": "Phone", "image": "lib/assets/images/phone.jpg"},

    {"name": "Watch", "image": "lib/assets/images/whatch.jpg"},

    {"name": "Tablet", "image": "lib/assets/images/tablet.jpg"},

    {"name": "Headphones", "image": "lib/assets/images/headphones1.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),

        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
          ),
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(10),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),

        itemCount: products.length,

        itemBuilder: (context, index) {
          final product = products[index];

          return InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(product: product),
                ),
              );

              if (result != null) {
                setState(() {});

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${product["name"]} added to favorites"),
                  ),
                );
              }
            },

            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(product["image"]!, fit: BoxFit.cover),
                  ),

                  Text(product["name"]!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//================ PRODUCT DETAILS =================

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["name"]!)),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(height: 300, child: Image.network(product["image"]!)),

            const SizedBox(height: 20),

            Text(product["name"]!, style: const TextStyle(fontSize: 25)),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.favorite),

              label: const Text("Add To Favorites"),

              onPressed: () {
                favoriteProducts.add(product);

                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}

//================ FAVORITES =================

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),

      body: ListView.builder(
        itemCount: favoriteProducts.length,

        itemBuilder: (context, index) {
          final product = favoriteProducts[index];

          return ListTile(
            leading: Image.network(product["image"]!, width: 50),

            title: Text(product["name"]!),
          );
        },
      ),
    );
  }
}
