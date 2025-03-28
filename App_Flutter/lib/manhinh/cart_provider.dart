import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Tour.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];
  List<Order> _orders = []; // Lưu danh sách đơn hàng
  String? _userEmail; // Lưu email user hiện tại

  List<Product> get cartItems => _cartItems;
  List<Order> get orders => _orders;

  void setUserEmail(String email) {
    _userEmail = email;
    loadCart();
    loadOrders(); // Load đơn hàng từ SharedPreferences khi người dùng đăng nhập
  }

  Future<void> addToCart(Product product) async {
    var existingProduct = _cartItems.firstWhere((item) => item.id == product.id,
        orElse: () => Product(
            id: -1,
            productType: '',
            name: '',
            description: '',
            img: [],
            thuongHieu: '',
            tinhTrang: '',
            price: 0.0));

    if (existingProduct.id == product.id) {
      existingProduct.quantity += 1;
    } else {
      _cartItems.add(product);
    }
    await saveCart();
    notifyListeners();
  }

  Future<void> removeFromCart(Product product) async {
    var existingProduct = _cartItems.firstWhere((item) => item.id == product.id,
        orElse: () => Product(
            id: -1,
            productType: '',
            name: '',
            description: '',
            img: [],
            thuongHieu: '',
            tinhTrang: '',
            price: 0.0));

    if (existingProduct.id == product.id) {
      if (existingProduct.quantity > 1) {
        existingProduct.quantity -= 1;
      } else {
        _cartItems.remove(product);
      }
    }
    await saveCart();
    notifyListeners();
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    await saveCart();
    notifyListeners();
  }

  Future<void> addOrder() async {
    if (_cartItems.isEmpty) return;

    // Tạo đơn hàng mới từ giỏ hàng
    Order newOrder = Order(
      items: _cartItems,
      totalPrice: totalPrice,
      date: DateTime.now(),
    );

    _orders.add(newOrder); // Thêm đơn hàng vào danh sách
    await saveOrders(); // Lưu đơn hàng
    await clearCart(); // Sau khi thanh toán, giỏ hàng sẽ được xóa
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  void removeOrder(int index) async {
    if (index >= 0 && index < _orders.length) {
      _orders.removeAt(index);
      await saveOrders(); // Cập nhật danh sách đơn hàng trong SharedPreferences
      notifyListeners();
    }
  }

  Future<void> saveCart() async {
    if (_userEmail == null) return;
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson =
        _cartItems.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList(
        'cart_$_userEmail', cartJson); // Lưu giỏ hàng theo email người dùng
  }

  Future<void> loadCart() async {
    if (_userEmail == null) return;
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList(
        'cart_$_userEmail'); // Tải giỏ hàng theo email người dùng

    if (cartJson != null) {
      _cartItems =
          cartJson.map((item) => Product.fromMap(jsonDecode(item))).toList();
      notifyListeners();
    }
  }

  // Lưu đơn hàng
  Future<void> saveOrders() async {
    if (_userEmail == null) return;
    final prefs = await SharedPreferences.getInstance();
    List<String> ordersJson =
        _orders.map((order) => jsonEncode(order.toMap())).toList();
    await prefs.setStringList(
        'orders_$_userEmail', ordersJson); // Lưu đơn hàng theo email người dùng
  }

  // Tải đơn hàng
  Future<void> loadOrders() async {
    if (_userEmail == null) return;
    final prefs = await SharedPreferences.getInstance();
    List<String>? ordersJson = prefs.getStringList(
        'orders_$_userEmail'); // Tải đơn hàng theo email người dùng

    if (ordersJson != null) {
      _orders =
          ordersJson.map((order) => Order.fromMap(jsonDecode(order))).toList();
      notifyListeners();
    }
  }
}
