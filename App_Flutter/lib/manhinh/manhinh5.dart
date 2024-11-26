import 'package:flutter/material.dart';
import 'dart:convert'; // Để xử lý JSON
import 'package:http/http.dart' as http;
import 'package:man_hinh/manhinh/manhinh1.dart';

class Manhinh6 extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<Manhinh6> {
  bool _notificationsEnabled = true;
  String fullName = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

Future<void> fetchUserData() async {
  final url = Uri.parse('https://gkiltdd.onrender.com/api/users');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("API Response: ${response.body}");
      final data = json.decode(response.body);

      // Xử lý nếu API trả về danh sách người dùng
      if (data is List && data.isNotEmpty) {
        setState(() {
          fullName = data[0]['full_name']?.toString() ?? "N/A";
          email = data[0]['email'] ?? "N/A";
        });
      }
      // Xử lý nếu API trả về đối tượng đơn lẻ
      else if (data is Map) {
        setState(() {
          fullName = data['full_name']?.toString() ?? "N/A";
          email = data['email'] ?? "N/A";
        });
      } else {
        throw "Unexpected API response structure";
      }
    } else {
      print("Failed to fetch data. Status code: ${response.statusCode}");
      setState(() {
        fullName = "Error loading name";
        email = "Error loading email";
      });
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      fullName = "Failed to fetch data";
      email = "Failed to fetch data";
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section with green background
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/icon6/image1.png'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(email, style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('EDIT PROFILE'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      backgroundColor: Colors.white, // Button text color
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Notifications with Switch
            ListTile(
              leading:
                  Image.asset('assets/icon6/icon1.png', width: 24, height: 24),
              title: Text('Notifications'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: Colors.green, // Green when enabled
              ),
            ),
            SettingsOption(
              title: 'Languages',
              iconPath: 'assets/icon6/icon2.png',
            ),
            SettingsOption(
              title: 'Payment Info',
              iconPath: 'assets/icon6/icon3.png',
            ),
            SettingsOption(
              title: 'Income Stats',
              iconPath: 'assets/icon6/icon4.png',
            ),
            SettingsOption(
              title: 'Privacy & Policies',
              iconPath: 'assets/icon6/icon5.png',
            ),
            SettingsOption(
              title: 'Feedback',
              iconPath: 'assets/icon6/icon6.png',
            ),
            SettingsOption(
              title: 'Usage',
              iconPath: 'assets/icon6/icon7.png',
            ),
            Spacer(),
            TextButton(
  onPressed: () async {
    // Clear any stored data (if any)
    // Then navigate to the login screen and remove all other routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Manhinh1()),
      (Route<dynamic> route) => false,  // Removes all previous routes
    );
  },
  child: Text('Sign out'),
  style: TextButton.styleFrom(
    foregroundColor: Colors.red,
  ),
),

          ],
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final String iconPath; // Custom image path for icon

  const SettingsOption({required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24, height: 24),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Handle tap
      },
    );
  }
}
