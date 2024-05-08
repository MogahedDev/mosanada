import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'auth.dart';
import 'app_them.dart';
import '../constants.dart';

class AddDonorScreen extends StatefulWidget {
  @override
  _AddDonorScreenState createState() => _AddDonorScreenState();
}

class _AddDonorScreenState extends State<AddDonorScreen> {
  late DatabaseReference dbref;
  @override
  void initState() {
    print("FFFFFFFFFFFFFFFFFFFFF");
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("Donor");
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController name_controller = TextEditingController();
  TextEditingController catgory_controller = TextEditingController();
  TextEditingController details_controller = TextEditingController();
  TextEditingController quantitye_controller = TextEditingController();
  var _image;
  late String _imageUrl;
  final picker = ImagePicker();
  Future getImageGallery() async {
    // ignore: deprecated_member_use
    var imageFile = await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      _image = File(imageFile.path);
      setState(() {});
    }
  }

  Future getImageCamera() async {
    // ignore: deprecated_member_use
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      _image = File(imageFile.path);
      setState(() {});
    }

    setState(() {});
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      // Create a unique filename for the image
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('$imageName');

      // Upload the file to Firebase Storage
      TaskSnapshot uploadTask = await storageReference.putFile(imageFile);

      // Get the URL of the uploaded image
      String imageUrl = await storageReference.getDownloadURL();
      getItemimages(imageUrl);
      // Return the URL of the uploaded image
      return imageUrl;
    } catch (e) {
      // Error uploading image
      print("Error uploading image: $e");
      return null;
    }
  }

  // uploadImage(String urlImage) async {
  //   List<int> imageBytes = _image1.readAsBytesSync();
  //   String imageB64 = base64Encode(imageBytes);
  //
  //   var response;
  //   response = await Uri.http.post(Uri.parse(urlImage), body: {
  //     "name": basename(_image1.path),
  //     "image": imageB64,
  //   })
  //       .timeout(Duration(
  //     seconds: 40,
  //   ))
  //       .catchError((e) async {});
  //   if (response.statusCode == 200) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: greenColor,
        title: Center(
            child: Text(
          "أضافة منتج ",
          style: TextStyle(color: lastColor),
        )),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),

            child: ListView(
              children: [
                Container(
                  height: 230,
                  width: 250,
                  child: Center(
                    // ignore: unnecessary_null_comparison
                    child: _image == null
                        ? const Icon(Icons.image)
                        : new Image.file(_image),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          child: Icon(Icons.image),
                          onPressed: () async {
                            getImageGallery();
                            String imageUrl =
                                await uploadImageToFirebaseStorage(_image)
                                    as String;
                            setState(() {
                              getItemimages(imageUrl);
                            });
                          }),
                      ElevatedButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: () async {
                            getImageCamera();
                          }),
                    ],
                  ),
                ),
                // name course

                SizedBox(
                  height: 10,
                ),
                //course price
                TextFormField(
                  controller: name_controller,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل  أسم  المنتج';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: ' فضلا أدخل أسم المنتج '),
                  onChanged: (String name) {
                    setState(() {
                      getItemName(name);
                    });
                  },
                ),
                TextFormField(
                  controller: catgory_controller,
                  onChanged: (String Category) {
                    setState(() {
                      getItemCategory(Category);
                    });
                  },
                  textAlign: TextAlign.right,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل  نوع المنتج';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: ' فضلا أدخل نوع المنتج '),
                ),
                TextFormField(
                  controller: details_controller,
                  onChanged: (String Details) {
                    setState(() {
                      getItemDetails(Details);
                    });
                  },
                  textAlign: TextAlign.right,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل  نبذة عن المنتج';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: ' فضلا أدخل نبذة عن المنتج '),
                ),
                TextFormField(
                  controller: quantitye_controller,
                  onChanged: (String ItemQty) {
                    setState(() {
                      getItemQty(ItemQty);
                    });
                  },
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل   كمية المنتج';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: ' فضلا أدخل  كمية المنتج '),
                ),
                // course currency price

                SizedBox(
                  height: 20,
                ),
                //check actived

                SizedBox(
                  height: 20,
                ),

                //button press

                TextButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xffE5B895), // Text color
                    padding: EdgeInsets.all(16), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Button border radius
                    ),
                  ),
                  onPressed: () async {
                    _formKey.currentState!.validate();
                    String imageUrl =
                        await uploadImageToFirebaseStorage(_image) as String;

                    createData();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'أضافة',
                    style: TextStyle(color: mainColor, fontSize: 30),
                  ),
                ),
              ],
            ),
            //     }else{
            // return Container();
            //     }
          ),
        ),
      ),
    );
  }
}
