import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Product {
  final int id;
  final String productType;
  final String name;
  final String description;
  final List<String> img;
  final String thuongHieu;
  final String tinhTrang;
  final double price;

  Product({
    required this.id,
    required this.productType,
    required this.name,
    required this.description,
    required this.img,
    required this.thuongHieu,
    required this.tinhTrang,
    required this.price,
  });

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
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.img.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://webbanhang-6.onrender.com/${product.img[0]}',
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                product.name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Thương hiệu: ${product.thuongHieu}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Text(
                'Tình trạng: ${product.tinhTrang}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Text(
                'Giá: ${product.price.toStringAsFixed(0)} VND',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                product.description,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];
  bool _isLoading = false;

  final Map<String, String> apiEndpoints = {
    "Rau củ": "/api/rau-cu",
    "Sinh tố": "/api/sinh-to",
    "Thực phẩm tươi sống": "/api/thuc-pham-tuoi-song",
    "Hoa quả": "/api/hoa-qua",
    "Các loại hạt": "/api/cac-loai-hat",
    "Gia vị": "/api/gia-vi",
  };

  String selectedApi = "";

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

  void onApiSelected(String api) {
    setState(() {
      selectedApi = api;
    });
    fetchProducts(api);
  }

  void _navigateToProductDetail(Product product) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ProductDetailScreen(product: product),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        elevation: 0,
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
                      onPressed: () => onApiSelected(apiEndpoints[category]!),
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
                        onTap: () => _navigateToProductDetail(product),
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
