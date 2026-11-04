import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'models/product_model.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  // Fungsi untuk mengambil data dari FakeStore API
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      // Mengubah string JSON menjadi tipe data Dart menggunakan jsonDecode
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Gagal memuat data produk');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Produk')),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data produk'));
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Harga: \$${product.price}\n${product.description}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
