import 'package:flutter/material.dart';
import 'package:kmdmobilehybrid/views/cart_page.dart';
import 'package:kmdmobilehybrid/views/home_page.dart';
import 'package:kmdmobilehybrid/views/login_page.dart';
import 'package:kmdmobilehybrid/views/records_page.dart';
import 'package:kmdmobilehybrid/views/register_page.dart';

import '../views/profile_page.dart';

class RouteUtils{

  static const String entryPage = "/";
  static const String loginPage = "/login";
  static const String registerPage = "/register";
  static const String homePage = "/home";
  static const String profilePage = "/profile";
  static const String cartPage = "/cart";
  static const String recordsPage = "/records";

  final routes = {
    entryPage: (context) => const LoginPage(),
    loginPage: (context) => const LoginPage(),
    registerPage: (context) => const RegisterPage(),
    homePage: (context) => const HomePage(),
    cartPage: (context) => const CartPage(),
    recordsPage: (context) => const RecordsPage(),
    profilePage: (context) => const ProfilePage(),
  };

}