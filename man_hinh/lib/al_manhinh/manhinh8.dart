import 'package:flutter/material.dart';

class Manhinh8 extends StatefulWidget {
  @override
  _GuideFilterScreenState createState() => _GuideFilterScreenState();
}

class _GuideFilterScreenState extends State<Manhinh8> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedLanguage;
  double fee = 0;

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
            'Filters',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Finding a Guide',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Tours'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Date
            Text('Date', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10),
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                          : "mm/dd/yy",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 20),

            // Time
            Text('Time', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 10),
                    Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : "00:00AM",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 20),

            // Guide's Language
            Text(
              'Guide\'s Language',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Chữ in đậm và màu đen
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  children: ['Vietnamese', 'English', 'Korean']
                      .map((language) => ChoiceChip(
                            label: Text(
                              language,
                              style: TextStyle(color: Colors.black),
                            ),
                            selected: selectedLanguage == language,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedLanguage = selected ? language : null;
                              });
                            },
                          ))
                      .toList(),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: ['Spanish', 'French']
                      .map((language) => ChoiceChip(
                            label: Text(
                              language,
                              style: TextStyle(color: Colors.black),
                            ),
                            selected: selectedLanguage == language,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedLanguage = selected ? language : null;
                              });
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Fee
            Text(
              'Fee',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold), // Chữ "Fee" in đậm
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icon.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 5),
                    Text('Fee', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Text('(\$/hour)', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 20),

            // Apply Filters Button
            ElevatedButton(
              onPressed: () {},
              child: Text('APPLY FILTERS', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
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
}
