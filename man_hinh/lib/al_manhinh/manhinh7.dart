import 'package:flutter/material.dart';

class Manhinh7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Số lượng tab
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images7/image3.png',
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
                        Colors.black.withOpacity(0.1),
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
                    'My Trips',
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
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images7/icon11.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              tabs: [
                Tab(text: 'Current Trips'),
                Tab(text: 'Next Trips'),
                Tab(text: 'Past Trips'),
                Tab(text: 'Wish List'),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TabBarView(
            children: [
              CurrentTripsTab(),
              Center(child: Text("Next Trips")),
              Center(child: Text("Past Trips")),
              Center(child: Text("Wish List")),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/images7/icon1.png',
                  width: 24, height: 24),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images7/icon2.png',
                  width: 24, height: 24),
              label: 'My Trips',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images7/icon3.png',
                  width: 24, height: 24),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images7/icon4.png',
                  width: 24, height: 24),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images7/icon5.png',
                  width: 24, height: 24),
              label: '',
            ),
          ],
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}

class CurrentTripsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images7/image1.png',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images7/icon6.png',
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Mark Finished',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Da Nang, Vietnam',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Dragon Bridge Trip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images7/icon7.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 4),
                        Text('Jan 30, 2020'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images7/icon8.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 4),
                        Text('13:00 - 15:00'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images7/icon9.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 4),
                        Text('Yoo Jin'),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images7/icon10.png', // Đường dẫn đến ảnh của biểu tượng
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: 8), // Khoảng cách giữa icon và text
                          Text(
                            'Detail',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
