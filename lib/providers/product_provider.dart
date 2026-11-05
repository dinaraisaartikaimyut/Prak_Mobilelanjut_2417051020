import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

enum ProductState { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  ProductState _state = ProductState.initial;
  List<Product> _products = [];
  String _errorMessage = '';

  // Getter untuk diakses oleh lapisan antarmuka pengguna
  ProductState get state => _state;
  List<Product> get products => _products;
  String get errorMessage => _errorMessage;
  bool get isLoading => _state == ProductState.loading;

  // Mengambil data dari layanan dan memberitahu pendengar (listener)
  Future<void> fetchProducts() async {
    _state = ProductState.loading;
    _errorMessage = '';
    notifyListeners(); // Memberitahu UI bahwa proses pemuatan sedang berlangsung

    try {
      _products = await _productService.getProducts();
      _state = ProductState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ProductState.error;
    }

    notifyListeners(); // Memberitahu UI bahwa data berhasil dimuat atau terjadi galat
  }
}
