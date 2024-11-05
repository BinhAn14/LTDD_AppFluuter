import 'package:flutter/material.dart';

class Manhinh5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/image1.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: 16,
                child: Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 169, 210, 244),
                  shape: BoxShape.circle, // Make it circular
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Chat',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ChatTile(
                  name: 'Yoo Jin',
                  message: 'It’s a beautiful place',
                  time: '9:41 AM',
                  unreadMessages: 2,
                  imageUrl: 'assets/images/image2.png',
                ),
                ChatTile(
                  name: 'Jonathan P',
                  message: 'We can start at 8am',
                  time: '10:30 AM',
                  imageUrl: 'assets/images/image3.png',
                ),
                ChatTile(
                  name: 'Myung Dae',
                  message: 'See you tomorrow',
                  time: '11:30 AM',
                  imageUrl: 'assets/images/image4.png',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon1.png', width: 24, height: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon2.png', width: 24, height: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon3.png', width: 24, height: 24),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon4.png', width: 24, height: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon5.png', width: 24, height: 24),
            label: '',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadMessages;
  final String imageUrl;

  ChatTile({
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    this.unreadMessages = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
        radius: 25,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: TextStyle(color: Colors.grey)),
          if (unreadMessages > 0)
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadMessages.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
