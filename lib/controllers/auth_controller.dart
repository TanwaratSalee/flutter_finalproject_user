import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  var isloading = false.obs;

  //textcontrollers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method

  Future<UserCredential?> signupMethod(
      { email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Storing data method
storeUserData({required String name, required String email, required String password}) async {
  try {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name': name, 'email': email, 'password': password, 'imageUrl': '',
      'id': currentUser?.uid,
      'day': day, 'month': month, 'year': year, 
      'cart_count' : "0",
      'wishlist_count': "0",
      'order_count' : "0"
    });
  } catch (e) {
    // Handle errors here, e.g., unable to store data
  }
}
  //Signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
