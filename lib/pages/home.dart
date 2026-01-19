import 'package:flutter/material.dart';

import '../widgets/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: TextStyle(
                color: Color.fromARGB(136, 0, 0, 0),
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.location_on, color: Color(0xff6e5038), size: 25),
                Text("Nairobi, Kenya", style: AppWidget.boldTextstyle(20.0)),
              ],
            ),
            SizedBox(height: 20.0),

            Container(
              margin: EdgeInsets.only(right: 20.0),
              decoration: BoxDecoration(border: Border.all()),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
