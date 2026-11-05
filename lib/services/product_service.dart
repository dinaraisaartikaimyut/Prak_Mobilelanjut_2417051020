import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  // Mengambil daftar seluruh produk
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception(
          'Gagal memuat produk (Kode Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  // Mengambil data rincian satu produk berdasarkan ID
  Future<Product> getProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat rincian produk');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}
