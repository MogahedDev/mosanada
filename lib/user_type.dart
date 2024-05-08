import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 1,
        title: Center(
            child: Text(
          "مــن تـكــون ؟",
          style: TextStyle(
              color: Color(0xffB1D4D6),
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the next screen when Container is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Container(
                      width: 180,
                      height: 160,
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.only(top: 60.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xffB1D4D6),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  "متبرع",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 140.0),
                                Icon(
                                  Icons.login_outlined,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the next screen when Container is tapped
                    },
                    child: Container(
                      width: 180,
                      height: 160,
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.only(top: 60.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xffB1D4D6),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  "مستفيد",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 120.0),
                                Icon(
                                  Icons.login_outlined,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the next screen when Container is tapped
                    },
                    child: Container(
                      width: 180,
                      height: 160,
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.only(top: 60.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xffB1D4D6),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.drive_eta,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  "مندوب توصيل",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 25.0),
                                Icon(
                                  Icons.login_outlined,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Add more ContactContainer widgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
