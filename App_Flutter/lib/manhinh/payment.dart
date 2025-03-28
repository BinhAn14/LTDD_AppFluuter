import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'order.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text("Thanh toán",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 100, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Giỏ hàng của bạn đang trống!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thông tin giỏ hàng:",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: product.img.isNotEmpty
                                  ? Image.network(
                                      'https://webbanhang-6.onrender.com/${product.img[0]}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(Icons.image_not_supported,
                                      size: 50, color: Colors.grey),
                            ),
                            title: Text(product.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                'x${product.quantity} - ${product.price.toStringAsFixed(0)} VND',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700])),
                            trailing:
                                Icon(Icons.check_circle, color: Colors.green),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                          "${cartProvider.totalPrice.toStringAsFixed(0)} VND",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        cartProvider.addOrder();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            title: Column(
                              children: [
                                Icon(Icons.check_circle,
                                    color: Colors.green, size: 60),
                                SizedBox(height: 10),
                                Text("Thanh toán thành công",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            content: Text(
                              "Cảm ơn bạn đã thanh toán. Đơn hàng của bạn sẽ được xử lý.",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderHistoryScreen()), // Điều hướng đến OrderHistoryScreen
                                    );
                                  },
                                  child: Text("OK",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.payment, size: 24, color: Colors.white),
                      label: Text("Thanh toán",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
