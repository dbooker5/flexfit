import 'package:flutter/material.dart';

import '../widgets/support_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool small = true, medium = false, large = false, xl = false, xxl = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "images/men-shirt.png",
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Men's Shirt", style: AppWidget.boldTextstyle(26.0)),
                  Text(
                    "Ksh100",
                    style: TextStyle(
                      color: Color(0xff6e5038),
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Product Details",
                style: AppWidget.boldTextstyle(20.0),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "A premium men’s shirt tailored for a sharp, polished look. Crafted from high-quality cotton blend fabric with a structured collar and button-down front — ideal for office wear and formal occasions.",
                style: TextStyle(
                  color: Color.fromARGB(149, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Select Size", style: AppWidget.boldTextstyle(20.0)),
            ),
            SizedBox(height: 10.0),

            Container(
              margin: EdgeInsets.only(left: 20.0),
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  small
                      ? AppWidget.selectedone("S")
                      : GestureDetector(
                          onTap: () {
                            small = true;
                            medium = false;
                            large = false;
                            xl = false;
                            xxl = false;
                            setState(() {});
                          },
                          child: AppWidget.nonSelected("S"),
                        ),
                  SizedBox(width: 20.0),
                  medium
                      ? AppWidget.selectedone("M")
                      : GestureDetector(
                          onTap: () {
                            small = false;
                            medium = true;
                            large = false;
                            xl = false;
                            xxl = false;
                            setState(() {});
                          },
                          child: AppWidget.nonSelected("M"),
                        ),
                  SizedBox(width: 20.0),
                  large
                      ? AppWidget.selectedone("L")
                      : GestureDetector(
                          onTap: () {
                            small = false;
                            medium = false;
                            large = true;
                            xl = false;
                            xxl = false;
                            setState(() {});
                          },
                          child: AppWidget.nonSelected("L"),
                        ),
                  SizedBox(width: 20.0),
                  xl
                      ? AppWidget.selectedone("XL")
                      : GestureDetector(
                          onTap: () {
                            small = false;
                            medium = false;
                            large = false;
                            xl = true;
                            xxl = false;
                            setState(() {});
                          },
                          child: AppWidget.nonSelected("XL"),
                        ),
                  SizedBox(width: 20.0),
                  xxl
                      ? AppWidget.selectedone("XXL")
                      : GestureDetector(
                          onTap: () {
                            small = false;
                            medium = false;
                            large = false;
                            xl = false;
                            xxl = true;
                            setState(() {});
                          },
                          child: AppWidget.nonSelected("XXL"),
                        ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Select Quantity",
                style: AppWidget.boldTextstyle(20.0),
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              margin: EdgeInsets.only(left: 20.0),
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(88, 0, 0, 0),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff6e5038),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),

                  Text("1", style: AppWidget.boldTextstyle(20.0)),

                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff6e5038),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
