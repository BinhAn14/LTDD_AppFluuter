import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:man_hinh/manhinh/cart_provider.dart';
import 'package:man_hinh/manhinh/cart_screen.dart';
import 'package:man_hinh/manhinh/order.dart';

class Product {
  final int id;
  final String productType;
  final String name;
  final String description;
  final List<String> img;
  final String thuongHieu;
  final String tinhTrang;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.productType,
    required this.name,
    required this.description,
    required this.img,
    required this.thuongHieu,
    required this.tinhTrang,
    required this.price,
    this.quantity = 1,
  });
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'product_type': productType,
      'name': name,
      'description': description,
      'img': img,
      'thuong_hieu': thuongHieu,
      'tinh_trang': tinhTrang,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'],
      productType: map['product_type'],
      name: map['name'],
      description: map['description'],
      img: List<String>.from(map['img']),
      thuongHieu: map['thuong_hieu'],
      tinhTrang: map['tinh_trang'],
      price: map['price'].toDouble(),
      quantity: map['quantity'],
    );
  }
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productType: json['product_type'],
      name: json['name'],
      description: json['description'],
      img: List<String>.from(json['img']),
      thuongHieu: json['thuong_hieu'],
      tinhTrang: json['tinh_trang'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'] ?? 1,
    );
  }
}

class Order {
  final List<Product> items;
  final double totalPrice;
  final DateTime date;

  Order({
    required this.items,
    required this.totalPrice,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'date': date.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      items: List<Product>.from(map['items']?.map((x) => Product.fromMap(x))),
      totalPrice: map['totalPrice'],
      date: DateTime.parse(map['date']),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.img.isNotEmpty)
              Center(
                child: Image.network(
                  'https://webbanhang-6.onrender.com/${product.img[0]}',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 10),
            Text(
              product.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '${product.price.toStringAsFixed(0)} VND',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              "Thương hiệu: ${product.thuongHieu}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              "Tình trạng: ${product.tinhTrang}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.all(15),
                ),
                onPressed: () {
                  cartProvider.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("${product.name} đã thêm vào giỏ hàng!")),
                  );
                },
                child:
                    Text("Thêm vào giỏ hàng", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, String> apiEndpoints = {
    "Rau củ": "/api/rau-cu",
    "Sinh tố": "/api/sinh-to",
    "Thực phẩm tươi sống": "/api/thuc-pham-tuoi-song",
    "Hoa quả": "/api/hoa-qua",
    "Các loại hạt": "/api/cac-loai-hat",
    "Gia vị": "/api/gia-vi",
  };

  Future<void> fetchProducts(String api) async {
    setState(() {
      _isLoading = true;
      _products = [];
    });
    try {
      var response = await Dio()
          .get('https://webbanhang-6.onrender.com/danh-muc-san-pham$api');
      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        setState(() {
          _products = responseData
              .map<Product>((item) => Product.fromJson(item))
              .toList();
        });
      }
    } catch (e) {
      print('Lỗi khi tải dữ liệu: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> searchProducts(String keyword) async {
    if (keyword.isEmpty) return;
    setState(() {
      _isLoading = true;
      _products = [];
    });
    try {
      var response = await Dio()
          .get('https://webbanhang-6.onrender.com/api/search?keyword=$keyword');
      if (response.statusCode == 200) {
        var responseData = response.data['data'];
        setState(() {
          _products = responseData
              .map<Product>((item) => Product.fromJson(item))
              .toList();
        });
      }
    } catch (e) {
      print('Lỗi khi tìm kiếm: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Tìm kiếm sản phẩm...",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.blue),
                onPressed: () => searchProducts(_searchController.text),
              ),
            ),
            onSubmitted: (value) => searchProducts(value),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                  ),
                  if (cartProvider.cartItems.isNotEmpty)
                    Positioned(
                      right: 2, // Dịch sang phải
                      top: -5, // Dịch lên trên
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          cartProvider.cartItems.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: apiEndpoints.keys.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => fetchProducts(apiEndpoints[category]!),
                      child: Text(category),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: product.img.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12)),
                                        child: Image.network(
                                          'https://webbanhang-6.onrender.com/${product.img[0]}',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(Icons.image_not_supported,
                                        size: 100),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        '${product.price.toStringAsFixed(0)} VND',
                                        style: TextStyle(color: Colors.green)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProductListScreen(),
  ));
}
