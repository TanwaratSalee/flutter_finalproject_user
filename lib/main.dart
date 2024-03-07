import 'package:flutter/material.dart';
import 'package:flutter_finalproject/Views/splash_screen/splash_screen.dart';
import 'package:flutter_finalproject/consts/colors.dart';
import 'package:flutter_finalproject/consts/styles.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = 'pk_live_51Oqu7zIDedZMPDPXXYtE8CoE5vO6mD9YVZvfzoHHyKyPxuC9G7DtdTr0fZLdxY1o3VZ1LpBTvUfuWPQJiUZ7FDRR003VaKtxGn';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: fontBlack),
          elevation: 0.0,
          backgroundColor: Colors.transparent),
          fontFamily: regular
      ),
      home: const SplashScreen(),
    );
  }
}