import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:man_hinh/manhinh/cart_provider.dart';
import 'Tour.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var orders = cartProvider.orders;

    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng đã mua",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                "Bạn chưa có đơn hàng nào.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        "Đơn hàng ${index + 1}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ngày mua: ${order.date.toLocal()}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Tổng tiền: ${order.totalPrice.toStringAsFixed(0)} VND',
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cartProvider.removeOrder(index);
                            },
                          ),
                          Icon(Icons.shopping_basket, color: Colors.green),
                        ],
                      ),
                      onTap: () {
                        _showOrderDetails(context, order);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Chi tiết đơn hàng", style: TextStyle(fontSize: 20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ngày mua: ${order.date.toLocal()}"),
            Text("Tổng tiền: ${order.totalPrice.toStringAsFixed(0)} VND"),
            SizedBox(height: 10),
            ...order.items.map((product) {
              return ListTile(
                leading: product.img.isNotEmpty
                    ? Image.network(
                        'https://webbanhang-6.onrender.com/${product.img[0]}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image_not_supported, size: 50),
                title: Text(product.name),
                subtitle: Text(
                    'x${product.quantity} - ${product.price.toStringAsFixed(0)} VND'),
              );
            }).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Đóng", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
