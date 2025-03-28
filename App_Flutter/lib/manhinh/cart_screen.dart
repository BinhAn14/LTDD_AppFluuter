import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'package:man_hinh/manhinh/payment.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        backgroundColor: Colors.green,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Giỏ hàng của bạn đang trống!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        elevation: 5,
                        child: ListTile(
                          leading: product.img.isNotEmpty
                              ? Image.network(
                                  'https://webbanhang-6.onrender.com/${product.img[0]}',
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.image_not_supported),
                          title: Text(product.name),
                          subtitle:
                              Text('${product.price.toStringAsFixed(0)} VND'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.red),
                                onPressed: () {
                                  if (product.quantity > 1) {
                                    cartProvider.removeFromCart(product);
                                  }
                                },
                              ),
                              Text(product.quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.green),
                                onPressed: () {
                                  cartProvider.addToCart(product);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cartProvider.removeFromCart(product);
                                  // Hiển thị SnackBar xác nhận xóa
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('${product.name} đã được xóa!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Tổng tiền: ${cartProvider.totalPrice.toStringAsFixed(0)} VND",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(),
                            ),
                          );
                        },
                        child:
                            Text("Thanh toán", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
