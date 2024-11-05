import 'package:flutter/material.dart';

void main() => runApp(Manhinh12());

class Manhinh12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyExperiencesPage(),
        debugShowCheckedModeBanner: false,
    );
  }
}

class MyExperiencesPage extends StatelessWidget {
  final List<Experience> experiences = [
    Experience(
      images: [
        'images/hinh1.png',
        'images/hinh2.png',
        'images/hinh3.png',
      ],
      title: '2 Hour Bicycle Tour exploring Hoian',
      location: 'Hoian, Vietnam',
      date: 'Jan 25, 2020',
      likes: 1234,
    ),
    Experience(
      images: [
        'images/hinh4.png',
        'images/hinh5.png',
        'images/hinh6.png',
      ],
      title: 'Food tour in Danang',
      location: 'Danang, Vietnam',
      date: 'Jan 20, 2020',
      likes: 234,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Experiences'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          return ExperienceCard(experience: experiences[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add experience
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class Experience {
  final List<String> images;
  final String title;
  final String location;
  final String date;
  final int likes;

  Experience({
    required this.images,
    required this.title,
    required this.location,
    required this.date,
    required this.likes,
  });
}

class ExperienceCard extends StatelessWidget {
  final Experience experience;

  ExperienceCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom layout for images
            Row(
              children: [
                // Left side image (image 1)
                Container(
                  width: screenWidth * 0.5, // Chiếm 60% chiều rộng màn hình
                  height: 208, // Chiều cao của hình 1
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(experience.images[0]), // Image 1
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Right side images (image 2 and image 3)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth * 0.4, // Chiếm 30% chiều rộng màn hình
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(experience.images[1]), // Image 2
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: screenWidth * 0.4, // Chiếm 30% chiều rộng màn hình
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(experience.images[2]), // Image 3
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Title and location
            Text(
              experience.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 5.0),
                Text(experience.location),
              ],
            ),
            SizedBox(height: 5.0),
            // Date and Likes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(experience.date),
                Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.grey),
                    SizedBox(width: 5.0),
                    Text('${experience.likes} Likes'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
