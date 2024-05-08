import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosanadah2024/auth.dart';

import 'app_them.dart';
import '../constants.dart';

class EditeDonorScreen extends StatefulWidget {
  late String name;
  late String catogery;
  late String item_details;
  late String quntety;
  late String image;
  EditeDonorScreen(
      this.name, this.catogery, this.item_details, this.quntety, this.image);
  @override
  _EditeDonorScreenState createState() => _EditeDonorScreenState();
}

class _EditeDonorScreenState extends State<EditeDonorScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name_controller = TextEditingController();
  TextEditingController catgory_controller = TextEditingController();
  TextEditingController details_controller = TextEditingController();
  TextEditingController quantitye_controller = TextEditingController();

  var _image;
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

  var imageUrl1;

  @override
  void initState() {
    super.initState();
    // Fetch item data when the page loads
    name_controller.text = widget.name;
    catgory_controller.text = widget.catogery;
    details_controller.text = widget.item_details;
    quantitye_controller.text = widget.quntety;
    imageUrl1 = widget.image;
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

      imageUrl1 = imageUrl;

      // Return the URL of the uploaded image
      return imageUrl;
    } catch (e) {
      // Error uploading image
      print("Error uploading image: $e");
      return null;
    }
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('DonorItems').doc(widget.name);

    Map<String, dynamic> DonorItems = ({
      "item_name": name_controller.text,
      "catogery": catgory_controller.text,
      "item_details": details_controller.text,
      "quntety": quantitye_controller.text,
      "image": imageUrl1,
    });

    // update data to Firebase
    documentReference
        .update(DonorItems)
        .whenComplete(() => print('$ItemName updated'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: greenColor,
        title: Center(
            child: Text(
          "تعديل منتج ",
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
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 230,
                  width: 250,
                  child: Center(
                    // ignore: unnecessary_null_comparison
                    child: _image == null
                        ? Image.network(imageUrl1)
                        : new Image.file(_image),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          child: Icon(Icons.image),
                          onPressed: () {
                            getImageGallery();
                          }),
                      ElevatedButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: () {
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل  أسم  المنتج';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: ' فضلا أدخل أسم المنتج '),
                ),
                TextFormField(
                  controller: catgory_controller,
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
                    if (_image == null) {
                      imageUrl1 = widget.image;
                    } else {
                      imageUrl1 =
                          await uploadImageToFirebaseStorage(_image) as String;
                    }
                    updateData();
                    Navigator.of(context).pop();

                    // Validate returns  true if the form is valid, or false otherwise.
                  },
                  child: Text(
                    'تعديل',
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
