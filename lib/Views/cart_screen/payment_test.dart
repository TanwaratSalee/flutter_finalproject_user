// import 'package:flutter/material.dart';
// import 'package:flutter_finalproject/Views/collection_screen/loading_indicator.dart';
// import 'package:flutter_finalproject/Views/widgets_common/our_button.dart';
// import 'package:flutter_finalproject/consts/colors.dart';
// import 'package:flutter_finalproject/consts/lists.dart';
// import 'package:flutter_finalproject/consts/styles.dart';
// import 'package:flutter_finalproject/controllers/cart_controller.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:get/get.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../home_screen/mainNavigationBar.dart';


// class StripePaymentHandle {
//   Map<String, dynamic>? paymentIntent;

//   Future<void> stripeMakePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('100', 'INR');
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   billingDetails: BillingDetails(
//                       name: 'YOUR NAME',
//                       email: 'YOUREMAIL@gmail.com',
//                       phone: 'YOUR NUMBER',
//                       address: Address(
//                           city: 'YOUR CITY',
//                           country: 'YOUR COUNTRY',
//                           line1: 'YOUR ADDRESS 1',
//                           line2: 'YOUR ADDRESS 2',
//                           postalCode: 'YOUR PINCODE',
//                           state: 'YOUR STATE')),
//                   paymentIntentClientSecret: paymentIntent![
//                       'client_secret'], //Gotten from payment intent
//                   style: ThemeMode.dark,
//                   merchantDisplayName: 'Ikay'))
//           .then((value) {});

//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//     } catch (e) {
//       print(e.toString());
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       // 3. display the payment sheet.
//       await Stripe.instance.presentPaymentSheet();

//       Fluttertoast.showToast(msg: 'Payment succesfully completed');
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         Fluttertoast.showToast(
//             msg: 'Error from Stripe: ${e.error.localizedMessage}');
//       } else {
//         Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
//       }
//     }
//   }

// //create Payment
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };

//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

// //calculate Amount
//   calculateAmount(String amount) {
//     final calculatedAmount = (int.parse(amount)) * 100;
//     return calculatedAmount.toString();
//   }
// }