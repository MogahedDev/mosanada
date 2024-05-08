import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model.dart';

class Auth {
  //1
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  //2
  User? _firebaseUser(auth.User? user) {
    //3
    if (user == null) {
      return null;
    }
    //4
    return User(user.uid, user.email);
  }

  //5
  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_firebaseUser);
  }

  //6
  Future<User?> handleSignInEmail(String email, String password) async {
    //7
    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    //8
    return _firebaseUser(result.user);
  }

  //9
  Future<User?> handleSignUp(String email, String password) async {
    //10
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    //11
    return _firebaseUser(result.user);
  }
}

late String ItemName, ItemID, ItemCategory, ItemDetails, Itemimages;
var ItemQty;
getItemName(name) {
  ItemName = name;
}

getItemID(id) {
  ItemID = id;
}

getItemCategory(Category) {
  ItemCategory = Category;
}

getItemimages(images) {
  Itemimages = images;
}

getItemDetails(Details) {
  ItemDetails = Details;
}

getItemQty(result) {
  ItemQty = int.parse(result);
}

// TODO Create Data
createData() {
  print("sssssssss");
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('DonorItems').doc(ItemName);
  print("ddddddddddddddd");

  // create Map to send data in key:value pair form
  Map<String, dynamic> DonorItems = ({
    "item_name": ItemName,
    "catogery": ItemCategory,
    "item_details": ItemDetails,
    "quntety": ItemQty,
    "image": Itemimages,
  });

  // send data to Firebase
  documentReference
      .set(DonorItems)
      .whenComplete(() => print('$ItemName created'));

  print("gggggggggggggggggggg");
}

// TODO Read Data
readData() {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('DonorItems').doc();

  documentReference.get().then((dataSnapshot) {
    print(dataSnapshot.data());
  });
}

// TODO Update Data

// TODO Delete Data
deleteData(ItemName1) {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('DonorItems').doc(ItemName1);

  // delete data from Firebase
  documentReference.delete().whenComplete(() => print(ItemName1 + 'deleted'));
}
// ====================================================== //
