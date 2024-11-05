import 'package:flutter/material.dart';

class Manhinh1 extends StatelessWidget {
  const Manhinh1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Sign In",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                Text("Welcome back, Tuan Tran",
                    style: TextStyle(color: Colors.green)),
                SizedBox(height: 15),
                Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                TextField(),
                SizedBox(height: 15),
                Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
                TextField(obscureText: true),
                SizedBox(height: 15),
                Text("Forgot Password"),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(child: Text('Or Sign in With')),
                SizedBox(height: 15),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/iconFacebook.png'),
                      SizedBox(width: 20),
                      Image.asset('images/iconKakao.png'),
                      SizedBox(width: 20),
                      Image.asset('images/iconLine.png'),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      Text("Sign up", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
