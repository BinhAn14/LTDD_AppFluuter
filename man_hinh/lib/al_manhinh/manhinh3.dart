import 'package:flutter/material.dart';

class Manhinh3 extends StatelessWidget {
  final List<Tour> tours = [
    Tour('Da Nang - Ba Na - Hoi An', 'Jan 30, 2020', 3, 400,
        'assets/danang.png'),
    Tour('Melbourne - Sydney', 'Jan 30, 2020', 3, 600, 'assets/halong.png'),
    Tour('Hanoi - Ha Long Bay', 'Jan 30, 2020', 3, 300, 'assets/sydney.png'),
    Tour('Da Nang - Ba Na - Hoi An', 'Jan 30, 2020', 3, 400,
        'assets/danang.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tours in Danang'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Hiển thị 2 tour mỗi hàng
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5, // Tỉ lệ card
        ),
        itemCount: tours.length,
        itemBuilder: (context, index) {
          return TourCard(tour: tours[index]);
        },
      ),
    );
  }
}

class Tour {
  final String title;
  final String date;
  final int duration;
  final int price;
  final String imageUrl;

  Tour(this.title, this.date, this.duration, this.price, this.imageUrl);
}

class TourCard extends StatelessWidget {
  final Tour tour;

  TourCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image.asset(
                  tour.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    );
                  }),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 125,
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 16),
                    SizedBox(width: 5),
                    Text(
                      '123 likes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề
                Text(
                  tour.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),

                // Ngày với biểu tượng icon
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(tour.date),
                  ],
                ),
                SizedBox(height: 5),

                // Row để hiển thị số ngày và giá
                Row(
                  children: [
                    Icon(Icons.timer, size: 16, color: Colors.grey),
                    SizedBox(width: 5),
                    Text('${tour.duration} days'),
                    Spacer(),
                    Text(
                      '\$${tour.price}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
