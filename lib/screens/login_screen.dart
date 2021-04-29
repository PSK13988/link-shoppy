import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/login_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  APICalling _apiCalling = APICalling();
  bool _passwordVisible = false;
  final FocusNode _email = FocusNode();
  final FocusNode _password = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  List<dynamic> companyList;

  @override
  void initState() {
    _passwordVisible = false;
    var fCurrentTheme = AppSharedPreference.getCurrentTheme();
    fCurrentTheme.then((value) {
      if (value != null) {
        print('Code : $value');
        _updateTheme(value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return createLayout();
  }

  Widget createLayout() {
    return BaseWidget(
      builder: (context, sizeConfig) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    Image.asset(
                      'images/logo.png',
                      height: 90,
                      width: 90,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email address or Mobile number',
                        labelText: 'Email address or Mobile number',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _email,
                      controller: _emailController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            Utility.showToast('Long press to see password');
                          },
                          onLongPress: () {
                            setState(() {
                              _passwordVisible = true;
                            });
                          },
                          onLongPressUp: () {
                            setState(() {
                              _passwordVisible = false;
                            });
                          },
                          child: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _password,
                      controller: _passwordController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonTheme(
                      height: 50.0,
                      child: RaisedButton(
                        color: AppConstants.colorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: AppConstants.colorPrimary)),
                        onPressed: () {
                          validateForm();
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppConstants.textMediumSize,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Not Registered Yet?'),
                        FlatButton(
                          onPressed: () {
                            AppRoutes.setFirst(context, '/register');
                          },
                          child: Text(
                            'Register Here',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void validateForm() {
    if (_emailController.text.trim().isEmpty) {
      Utility.showToast('Email or Mobile is required');
      _email.requestFocus();
      return;
    }

    if (Utility.isNumeric(_emailController.text)) {
      // Mobile
      if (_emailController.text.length < 10) {
        Utility.showToast('Please enter valid mobile number');
        _email.requestFocus();
        return;
      }
    } else {
      //Email
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailController.text.trim());
      if (!emailValid) {
        Utility.showToast('Email address is not valid');
        _email.requestFocus();
        return;
      }
    }

    if (_passwordController.text.trim().isEmpty) {
      Utility.showToast('Password is required');
      _password.requestFocus();
      return;
    }

    /*Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodedPassword =
        stringToBase64.encode(_passwordController.text.trim());*/

    var networkAvailable = Utility.isNetworkAvailable();
    if (networkAvailable != null) {
      networkAvailable.then((isNetworkReady) {
        if (isNetworkReady) {
          var loginToken =
              _apiCalling.getLogin(email: _emailController.text.trim(), password: _passwordController.text.trim());
          if (loginToken != null) {
            loginToken.then((jsonResponse) {
              if (jsonResponse != null && jsonResponse.isNotEmpty) {
                final Map parsed = json.decode(jsonResponse);
                var loginResponse = LoginResponse.map(parsed);
                if (loginResponse.success) {
                  Utility.showToast('Login Successful');
                  AppSharedPreference.setEmail(loginResponse.email);
                  AppSharedPreference.setJwtToken(loginResponse.jwt);
                  AppSharedPreference.setRefreshToken(loginResponse.refresh);
                  AppSharedPreference.setUserId(loginResponse.userData.id);
                  setState(() {
                    AppConstants.jwt = loginResponse.jwt;
                    AppConstants.refresh = loginResponse.refresh;
                  });
                  //AppSharedPreference.setUserData(loginResponse.userData);
                  // Setting firstTimeLaunch flag
                  AppSharedPreference.setFirstTimeLaunch(true);
                  //loginResponse.userRole = '2';
                  AppSharedPreference.setUserRole(loginResponse.userRole);
                  // For Vendor route

                  if (loginResponse.userRole == AppConstants.VENDOR_ROLE) {
                    // Redirect to Home
                    if (loginResponse.shopSetup != false) {
                      AppSharedPreference.setShopVerified(true);
                      print('Shop category ${loginResponse.shopSetup}');
                      AppSharedPreference.setCategoryId(loginResponse.shopSetup);
                      AppRoutes.setFirst(context, '/home');
//                    AppRoutes.setFirst(context, '/shopSetup');
                    } else {
                      AppRoutes.setFirst(context, '/shopSetup');
                    }
                  } else if (loginResponse.userRole == AppConstants.USER_ROLE) {
                    // For User Route
                    AppRoutes.setFirst(context, '/userCategorySelection');
                  }
                } else {
                  Utility.showToast('Login failed please enter valid credentials');
                }
              } else {
                Utility.showToast(AppConstants.MSG_UNKNOWN_ERROR);
              }
            });
          }
        } else {
          Utility.showToast(AppConstants.MSG_INTERNET_NOT);
        }
      });
    } else {
      Utility.showToast(AppConstants.MSG_NETWORK_CHECK);
    }
  }

  void _updateTheme(int code) {
    switch (code) {
      case 0:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorDocPrimary;
          AppConstants.colorAccent = AppConstants.colorDocAccent;
        });
        break;
      case 1:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorOnePrimary;
          AppConstants.colorAccent = AppConstants.colorOneAccent;
        });
        break;
      case 2:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTwoPrimary;
          AppConstants.colorAccent = AppConstants.colorTwoAccent;
        });
        break;
      case 3:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorThreePrimary;
          AppConstants.colorAccent = AppConstants.colorThreeAccent;
        });
        break;
      case 4:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFourPrimary;
          AppConstants.colorAccent = AppConstants.colorFourAccent;
        });
        break;
      case 5:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFivePrimary;
          AppConstants.colorAccent = AppConstants.colorFiveAccent;
        });
        break;
      case 6:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSixPrimary;
          AppConstants.colorAccent = AppConstants.colorSixAccent;
        });
        break;
      case 7:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSevenPrimary;
          AppConstants.colorAccent = AppConstants.colorSevenAccent;
        });
        break;
      case 8:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorEightPrimary;
          AppConstants.colorAccent = AppConstants.colorEightAccent;
        });
        break;
      case 9:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorNinePrimary;
          AppConstants.colorAccent = AppConstants.colorNineAccent;
        });
        break;
      case 10:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTenPrimary;
          AppConstants.colorAccent = AppConstants.colorTenAccent;
        });
        break;
      case 11:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorElevenPrimary;
          AppConstants.colorAccent = AppConstants.colorElevenAccent;
        });
        break;
      case 12:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTwelvePrimary;
          AppConstants.colorAccent = AppConstants.colorTwelveAccent;
        });
        break;
      case 13:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorThirteenPrimary;
          AppConstants.colorAccent = AppConstants.colorThirteenAccent;
        });
        break;
      case 14:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFourteenPrimary;
          AppConstants.colorAccent = AppConstants.colorFourteenAccent;
        });
        break;
      case 15:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFifteenPrimary;
          AppConstants.colorAccent = AppConstants.colorFifteenAccent;
        });
        break;
      case 16:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSixteenPrimary;
          AppConstants.colorAccent = AppConstants.colorSixteenAccent;
        });
        break;
      case 17:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSeventeenPrimary;
          AppConstants.colorAccent = AppConstants.colorSeventeenAccent;
        });
        break;
      case 18:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorEighteenPrimary;
          AppConstants.colorAccent = AppConstants.colorEighteenAccent;
        });
        break;
      case 19:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorNineteenPrimary;
          AppConstants.colorAccent = AppConstants.colorNineteenAccent;
        });
        break;
    }
  }
}
