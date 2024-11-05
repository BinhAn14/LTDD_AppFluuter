import 'package:flutter/material.dart';

class Manhinh2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Trip Detail',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/hanoi.png', // Trip image
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Row(
                      children: [
                        Icon(Icons.location_pin, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Hanoi, Vietnam',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green, // Border color
                          width: 4.0, // Border thickness
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/stephne.png'), // Traveler avatar
                        radius: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Information Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('Feb 2, 2020'),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Time',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('8:00AM - 10:00AM')),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Traveler',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('Stephne')),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Number of Travelers',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('2')),
              ],
            ),
            SizedBox(height: 10),

            Text(
              'Attractions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Wrap(
              spacing: 10.0,
              runSpacing: 5.0,
              children: [
                Chip(
                  avatar: Icon(Icons.location_pin,
                      color: const Color.fromARGB(255, 153, 218, 155)),
                  label: Text('Ho Guom'),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 153, 218, 155)),
                  side: BorderSide(color: Colors.white, width: 1.0),
                ),
                Chip(
                  avatar: Icon(Icons.location_pin,
                      color: const Color.fromARGB(255, 153, 218, 155)),
                  label: Text('Ho Chi Minh Mausoleum'),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 153, 218, 155)),
                  side: BorderSide(color: Colors.white, width: 1.0),
                ),
                Chip(
                  avatar: Icon(Icons.location_pin,
                      color: const Color.fromARGB(255, 153, 218, 155)),
                  label: Text('Pho 12 Kim Ma St.'),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 153, 218, 155)),
                  side: BorderSide(color: Colors.white, width: 1.0),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Text(
                  'Fee',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                Spacer(),
                Text(
                  '\$20.00',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('REJECT'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(width: 70),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('ACCEPT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
