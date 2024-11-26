import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:man_hinh/al_manhinh/manhinh3.dart';
import 'package:man_hinh/al_manhinh/manhinh5.dart';
import 'package:man_hinh/al_manhinh/notifications_screen.dart';

class Manhinh3 extends StatefulWidget {
  @override
  _Manhinh3State createState() => _Manhinh3State();
}

class _Manhinh3State extends State<Manhinh3> {
  int _selectedIndex = 0;
  List<Tour> tours = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTours();
  }

  Future<void> fetchTours() async {
    try {
      final response = await http
          .get(Uri.parse('https://gkiltdd.onrender.com/api/trips'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          tours = data
              .map((item) => Tour(
                    title: item['tripName'],
                    date: DateTime.parse(item['time']).toLocal().toString(),
                    duration: item['days'],
                    price: item['price'],
                    imageUrl: item['avatar'],
                  ))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load tours');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching tours: $error');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Manhinh3()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessagesScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Notifications()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tours in Danang'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tours.isEmpty
              ? Center(child: Text('No tours available'))
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: tours.length,
                  itemBuilder: (context, index) {
                    return TourCard(tour: tours[index]);
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Tours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
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

  Tour({
    required this.title,
    required this.date,
    required this.duration,
    required this.price,
    required this.imageUrl,
  });
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
                child: CachedNetworkImage(
                  imageUrl: tour.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                Text(
                  tour.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(tour.date),
                  ],
                ),
                SizedBox(height: 5),
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

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Manhinh5(),
    );
  }
}

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationsScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Manhinh6(),
    );
  }
}