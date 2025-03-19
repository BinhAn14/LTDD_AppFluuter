import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:man_hinh/manhinh/dangnhap.dart';

class Manhinh6 extends StatefulWidget {
  final String email;

  Manhinh6({required this.email});

  @override
  _Manhinh6State createState() => _Manhinh6State();
}

class _Manhinh6State extends State<Manhinh6> {
  bool _notificationsEnabled = true;
  bool _isEditingProfile = false;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  String fullName = "Loading...";
  String email = "Loading...";
  String phoneNumber = "Loading...";
  String address = "Loading...";
  String country = "Loading...";
  String? _userId; // Thêm biến lưu userId

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
        final data = json.decode(response.body);
        if (data is List) {
          final currentUser = data.firstWhere(
            (user) => user['email'] == widget.email,
            orElse: () => null,
          );

          if (currentUser != null) {
            setState(() {
              _userId = currentUser['_id'];
              fullName = currentUser['full_name'] ?? "N/A";
              email = currentUser['email'] ?? "N/A";
              phoneNumber = currentUser['phone_number'] ?? "N/A";
              address = currentUser['address'] ?? "N/A";
              country = currentUser['country'] ?? "N/A";

              fullNameController.text = fullName;
              emailController.text = email;
              phoneController.text = phoneNumber;
              addressController.text = address;
              countryController.text = country;
            });
          }
        }
      }
    } catch (e) {
      setState(() {
        fullName = "Lỗi lấy thông tin";
      });
    }
  }

  Future<void> _editProfile() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Không tìm thấy ID người dùng")),
      );
      return;
    }

    final String apiUrl =
        'https://gkiltdd.onrender.com/api/users/update/$_userId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "full_name": fullNameController.text,
          "email": emailController.text,
          "phone_number": phoneController.text,
          "address": addressController.text,
          "country": countryController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cập nhật thành công")),
        );
        setState(() {
          _isEditingProfile = false;
        });
        fetchUserData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi cập nhật: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }
  }

  Future<void> _signOut() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Manhinh1()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditingProfile ? 'Edit Profile' : 'Profile'),
        leading: _isEditingProfile
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isEditingProfile = false;
                  });
                },
              )
            : null,
      ),
      body: _isEditingProfile ? _buildEditProfile() : _buildSettings(),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  onPressed: () {
                    setState(() {
                      _isEditingProfile = true;
                    });
                  },
                  child: Text('EDIT PROFILE'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
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
              activeColor: Colors.green,
            ),
          ),
          SettingsOption(
              title: 'Languages', iconPath: 'assets/icon6/icon2.png'),
          SettingsOption(
              title: 'Payment Info', iconPath: 'assets/icon6/icon3.png'),
          SettingsOption(
              title: 'Income Stats', iconPath: 'assets/icon6/icon4.png'),
          SettingsOption(
              title: 'Privacy & Policies', iconPath: 'assets/icon6/icon5.png'),
          SettingsOption(title: 'Feedback', iconPath: 'assets/icon6/icon6.png'),
          SettingsOption(title: 'Usage', iconPath: 'assets/icon6/icon7.png'),
          Spacer(),
          TextButton(
            onPressed: _signOut,
            child: Text('Sign out'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/icon6/image1.png'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: fullNameController,
            decoration: InputDecoration(labelText: "Full Name"),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Phone Number"),
          ),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(labelText: "Address"),
          ),
          TextFormField(
            controller: countryController,
            decoration: InputDecoration(labelText: "Country"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _editProfile,
            child: Text("SAVE"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final String iconPath;

  const SettingsOption({required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24, height: 24),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
