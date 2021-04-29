import 'dart:async';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //AppSharedPreference.setShopVerified(false);
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    var fFirstTimeLaunch = AppSharedPreference.isFirstTimeLaunch();
    var userRole = AppSharedPreference.getUserRole();
    //var fShopVerified = AppSharedPreference.isShopVerified();
//    if (fFirstTimeLaunch != null && fShopVerified != null) {
    fFirstTimeLaunch.then((isFirstTimeLaunch) {
//        fShopVerified.then((shopVerified) {
      if (isFirstTimeLaunch != null) {
        if (isFirstTimeLaunch) {
          userRole.then((role) {
            if (role != null) {
              if (role == AppConstants.VENDOR_ROLE) {
                AppRoutes.setFirst(context, '/home');
              } else if (role == AppConstants.USER_ROLE) {
                AppRoutes.setFirst(context, '/userCategorySelection');
              }
            } else {
              Navigator.pushReplacementNamed(context, '/');
            }
          });

          //AppRoutes.setFirst(context, '/shopSetup');
        }
        /*else if (!shopVerified) {
              AppRoutes.setFirst(context, '/shopSetup');
            }*/
        else {
          Navigator.pushReplacementNamed(context, '/');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
//      });
//    }
//    else {
//      Navigator.pushReplacementNamed(context, '/');
//    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizeConfig) {
        bool isPortrait =
            Orientation.portrait == MediaQuery.of(context).orientation;
        print('isPortrait : $isPortrait');
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'images/logo.png',
                height: isPortrait
                    ? SizeConfig.safeBlockVertical * 20
                    : SizeConfig.safeBlockHorizontal * 20,
                width: isPortrait
                    ? SizeConfig.safeBlockHorizontal * 20
                    : SizeConfig.safeBlockVertical * 20,
              ),
              /*Text(
                AppConstants.APP_NAME,
                style: TextStyle(
                    fontSize: isPortrait
                        ? SizeConfig.defaultPMenuSize
                        : SizeConfig.defaultLMenuSize,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),*/
            ],
          ),
        );
      },
    );
  }
}
