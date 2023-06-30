// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:salford_spa_flutter_app/model/product_model.dart';
//
// class AddToCartController extends GetxController {
//   List<Products> productsList = [];
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   var cartItems = 0.obs;
//   int cartItemsTotal = 0;
//
//   void addProduct(Products product) {
//     productsList.add(product);
//     update();
//   }
//
//   void fetchCartItems() {
//     int total = 0 ;
//     FirebaseFirestore.instance
//         .collection('UserCart').where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productStatus', isEqualTo: 'Pending')
//         .get().then((value) {
//        cartItems.value = value.docs.length;
//
//        for(int i=0 ;i <value.docs.length ; i++) {
//          cartItemsTotal = total + int.parse(value.docs[i]['productPrice'].toString());
//        }
//
//        update();
//     }).whenComplete(() {
//       update();
//     });
//     update();
//
//   }
//
//   del(int index) {
//     productsList.removeAt(index);
//     update();
//   }
// }