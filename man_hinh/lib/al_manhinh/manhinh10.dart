import 'package:flutter/material.dart';

class Manhinh10 extends StatefulWidget {
  @override
  _Manhinh10State createState() => _Manhinh10State();
}

class _Manhinh10State extends State<Manhinh10> {
  String? selectedReason;
  final TextEditingController anotherReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Trip Detail',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reject the Trip",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "The reason why you reject this trip",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // List of reasons
            Column(
              children: [
                _buildRadioOption(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                _buildRadioOption(
                    "Lorem Ipsum has been the industry's standard dummy text ever since the."),
                _buildRadioOption("It has survived not only five centuries."),
                _buildRadioOption(
                    "But also the leap into electronic typesetting, remaining essentially unchanged."),
              ],
            ),
            SizedBox(height: 16),

            // Another reason input
            TextField(
              controller: anotherReasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Another reason",
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Reject button
            ElevatedButton(
              onPressed: () {
                // Handle rejection
                print("Selected Reason: $selectedReason");
                print("Another Reason: ${anotherReasonController.text}");
              },
              child: Text(
                'REJECT',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build radio button options
  Widget _buildRadioOption(String text) {
    return ListTile(
      leading: Radio<String>(
        value: text,
        groupValue: selectedReason,
        onChanged: (String? value) {
          setState(() {
            selectedReason = value;
          });
        },
      ),
      title: Text(text),
    );
  }
}
