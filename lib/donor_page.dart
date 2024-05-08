import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mosanadah2024/login_page.dart';
import '../constants.dart';
import 'add_donor.dart';
import 'app_them.dart';
import 'edite_donor.dart';

class DonorScreen extends StatefulWidget {
  @override
  _DonorScreenState createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
    // Navigate to login page or any other page after logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: grayColor,
            ),
            onPressed: signOut,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: grayColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: greenColor,
        title: Center(
            child: Text(
          " صفحة المتبرع",
          style: TextStyle(color: grayColor),
        )),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('DonorItems').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('...تحميل');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Container(
                margin: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: lastColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Card(
                  color: greenColor,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 40.0,
                          child: Image.network(data['image']),
                        ),
                        title: Text(
                          data['item_name'],
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: grayColor),
                        ),
                        subtitle: Text(data['item_details'],
                            style: TextStyle(fontSize: 16.0, color: grayColor)),
                        trailing: Text(data['quntety'].toString(),
                            style: TextStyle(fontSize: 16.0, color: grayColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.delete,
                                color: lastColor,
                                size: 35.0,
                              ),
                              onTap: () async {
                                bool result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      titleTextStyle: kTitleTextStyle,
                                      contentTextStyle: kTitleTextStyle,
                                      backgroundColor: mainColor,
                                      title: Text(
                                        'تأكيد',
                                        style: kTitleTextStyle,
                                      ),
                                      content: Text(
                                        'هل انت متاكد من الحذف ؟',
                                        style: kTitleTextStyle,
                                      ),
                                      actions: <Widget>[
                                        new TextButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(
                                                    false); // dismisses only the dialog and returns false
                                          },
                                          child: Text(
                                            'لأ',
                                            style: kTitleTextStyle,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            DocumentReference
                                                documentReference =
                                                FirebaseFirestore.instance
                                                    .collection('DonorItems')
                                                    .doc(data['item_name']);

                                            // delete data from Firebase
                                            documentReference
                                                .delete()
                                                .whenComplete(() => print(
                                                    data['item_name'] +
                                                        'deleted'));

                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(
                                                    true); // dismisses only the dialog and returns true
                                          },
                                          child: Text(
                                            'نعم',
                                            style: kTitleTextStyle,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: 35.0,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: lastColor,
                                size: 35.0,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditeDonorScreen(
                                            data['item_name'],
                                            data['catogery'],
                                            data['item_details'],
                                            data['quntety'].toString(),
                                            data['image'])));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

              // return ListTile(
              //   leading: CircleAvatar(
              //     radius: 40.0,
              //     child: Image.asset('assets/m3.png'),
              //   ),
              //   title: Text(
              //     data['item_name'],
              //     style: TextStyle(
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.bold,
              //         color: grayColor),
              //   ),
              //   subtitle: Text(data['item_details'],
              //       style: TextStyle(fontSize: 16.0, color: grayColor)),
              //   trailing: Text(data['quntety'].toString(),
              //       style: TextStyle(fontSize: 16.0, color: grayColor)),
              // );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDonorScreen()));
        },
      ),
    );
  }
}






       
// //       floatingActionButton: FloatingActionButton(
// //         child: Icon(Icons.add),
// //         onPressed: () {
// //           Navigator.push(context,
// //               MaterialPageRoute(builder: (context) => AddDonorScreen()));
// //         },
// //       ),
// //     );
// //   }
// // }
