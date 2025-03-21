import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Vegetables'),
        backgroundColor: const Color(0xFF4CAF50),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Tiêu đề danh sách thông báo
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Thông Báo Mới Nhất',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
                ),
              ),
            ),

            // Các thẻ thông báo
            NotificationCard(
              title: 'Giá rau cải đã giảm!',
              description: 'Hôm nay rau cải chỉ còn 20.000đ/kg. Mua ngay! 🥬',
              time: 'Vừa xong',
              imageAsset: Image.asset('assets/images/raucai.jpg'),
            ),
            NotificationCard(
              title: 'Cà chua hữu cơ mới về',
              description: 'Cà chua chín mọng, đạt chuẩn hữu cơ 100%! 🍅',
              time: '10 phút trước',
              imageAsset: Image.asset('assets/images/cachua.jpg'),
            ),
            NotificationCard(
              title: 'Khuyến mãi lớn cuối tuần',
              description: 'Giảm 20% cho tất cả các loại rau củ! 🛒',
              time: '1 giờ trước',
              imageAsset: Image.asset('assets/images/raucu.png'),
            ),
            NotificationCard(
              title: 'Chanh tươi mới nhập tại cửa hàng',
              description: 'Giảm 10% 🛒',
              time: '1 ngày trước',
              imageAsset: Image.asset('assets/images/chanh.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final Image imageAsset;

  NotificationCard({
    required this.title,
    required this.description,
    required this.time,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: Container(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageAsset,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2E7D32),
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        trailing: Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
