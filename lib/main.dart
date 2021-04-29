import 'package:app/screens/add_subcategory_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/shop_setup_screen.dart';
import 'package:app/screens/shop_sub_category_setup_screen.dart';
import 'package:app/screens/register_screen.dart';
import 'package:app/screens/test_screen.dart';
import 'package:app/screens/user_category_selection_screen.dart';
import 'package:app/screens/user_login_screen.dart';
import 'package:app/screens/user_register_screen.dart';
import 'package:app/screens/yyyy.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/splash',
        routes: {
          '/': (context) => LoginScreen(),
          '/splash': (context) => SplashScreen(),
          '/shopSetup': (context) => ShopSetupScreen(),
          '/home': (context) => HomeScreen(),
          '/register': (context) => RegisterScreen(),
          '/shopSubCategorySetup': (context) => ShopSubCategorySetupScreen(),
          '/addSubCategory': (context) => AddSubCategoryScreen(),
          '/userRegister': (context) => UserRegisterScreen(),
          '/userLogin': (context) => UserLoginScreen(),
          '/userCategorySelection': (context) => UserCategorySelectionScreen(),
          '/test': (context) => TestScreen(),
          '/yyy': (context) => HelloScreen(),
        },
      ),
    );
