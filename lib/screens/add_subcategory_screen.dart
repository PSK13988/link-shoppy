import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/status_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class AddSubCategoryScreen extends StatefulWidget {
  @override
  _AddSubCategoryScreenState createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen> {
  APICalling _apiCalling = APICalling();
  bool _passwordVisible = false;
  final FocusNode _email = FocusNode();
  final FocusNode _password = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
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
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
          var loginToken = _apiCalling.getLogin(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
          if (loginToken != null) {
            loginToken.then((jsonResponse) {
              if (jsonResponse != null && jsonResponse.isNotEmpty) {
                final Map parsed = json.decode(jsonResponse);
                var statusResponse = StatusResponse.map(parsed);
                if (statusResponse.success) {
                  Utility.showToast('Sub Category Added Successfully');
                  //showAlertDialog(context);
                } else {
                  Utility.showToast(statusResponse.message);
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
}
