import 'package:cloud_firestore/cloud_firestore.dart';

//User Methods

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(userInfoMap);
  }

  Future<DocumentSnapshot> getUserDetails(String id) async {
    return await FirebaseFirestore.instance.collection("Users").doc(id).get();
  }

  // Product Methods

  Future addProducts(Map<String, dynamic> productInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .add(productInfoMap);
  }

  // Method to fetch all products for your Home Page
  Stream<QuerySnapshot> getAllProducts() {
    return FirebaseFirestore.instance.collection("Products").snapshots();
  }

  // Method to fetch products by category for your Category Page
  Stream<QuerySnapshot> getProductsByCategory(String category) {
    return FirebaseFirestore.instance
        .collection("Products")
        .where("Category", isEqualTo: category)
        .snapshots();
  }
}
