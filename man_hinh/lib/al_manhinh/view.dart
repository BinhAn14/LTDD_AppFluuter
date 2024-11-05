import 'package:flutter/material.dart';
import 'package:man_hinh/al_manhinh/manhinh1.dart';
import 'package:man_hinh/al_manhinh/manhinh2.dart';
import 'package:man_hinh/al_manhinh/manhinh3.dart';
import 'package:man_hinh/al_manhinh/manhinh4.dart';
import 'package:man_hinh/al_manhinh/manhinh5.dart';
import 'package:man_hinh/al_manhinh/manhinh6.dart';
import 'package:man_hinh/al_manhinh/manhinh7.dart';
import 'package:man_hinh/al_manhinh/manhinh8.dart';
import 'package:man_hinh/al_manhinh/manhinh9.dart';
import 'package:man_hinh/al_manhinh/manhinh10.dart';
import 'package:man_hinh/al_manhinh/manhinh11.dart';
import 'package:man_hinh/al_manhinh/manhinh12.dart';

class ManhinhFlutter extends StatefulWidget {
  const ManhinhFlutter({super.key});

  @override
  State<ManhinhFlutter> createState() => _ManhinhFlutterState();
}

class _ManhinhFlutterState extends State<ManhinhFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Manhinh12(),
          ManHinh11(),
          Manhinh1(),
          Manhinh2(),
          Manhinh3(),
          Manhinh4(),
          Manhinh5(),
          Manhinh6(),
          Manhinh7(),
          Manhinh8(),
          Manhinh9(),
          Manhinh10(),
          
        ],
      ),
    );
  }
}
