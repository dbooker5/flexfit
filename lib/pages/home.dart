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

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(86, 0, 0, 0),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for Clothing's..",
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.only(right: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xff6e5038),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Image.asset("images/banner.png"),
            ),
            SizedBox(height: 10.0),

            Text("Category", style: AppWidget.boldTextstyle(24.0)),
            SizedBox(height: 10.0),

            Row(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 224, 211),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Image.asset(
                        "images/t-shirt.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        color: Color(0xff6e5038),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text("T-Shirts", style: AppWidget.boldTextstyle(18.0)),
                  ],
                ),
                SizedBox(width: 20.0),

                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 224, 211),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Image.asset(
                        "images/t-shirt.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        color: Color(0xff6e5038),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text("T-Shirts", style: AppWidget.boldTextstyle(18.0)),
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
