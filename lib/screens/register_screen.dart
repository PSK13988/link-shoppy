import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/status_response.dart';
import 'package:app/models/pojos/user_model.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  APICalling _apiCalling = APICalling();
  bool _passwordVisible = false;
  final FocusNode _fullName = FocusNode();
  final FocusNode _email = FocusNode();
  final FocusNode _password = FocusNode();
  final FocusNode _mobile = FocusNode();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  static UserModel userModel = UserModel(label: 'User', value: '3');
  static UserModel vendorModel = UserModel(label: 'Vendor', value: '2');
  List<UserModel> userList = [vendorModel, userModel];
  UserModel _selectedUser = vendorModel;

  @override
  void initState() {
    _passwordVisible = false;
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
                      height: MediaQuery.of(context).size.height / 14,
                    ),
                    Image.asset(
                      'images/logo.png',
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Full Name',
                        labelText: 'Full Name',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _fullName,
                      controller: _fullNameController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email ID',
                        labelText: 'Email ID',
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
                        hintText: 'Password',
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
                      textInputAction: TextInputAction.next,
                      focusNode: _password,
                      controller: _passwordController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Mobile',
                        labelText: 'Mobile',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      focusNode: _mobile,
                      controller: _mobileController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      child: DropdownButtonFormField<UserModel>(
                        isExpanded: true,
                        value: _selectedUser,
                        items: userList
                            .map((label) => DropdownMenuItem<UserModel>(
                                  child: Text(label.label),
                                  value: label,
                                ))
                            .toList(),
                        decoration: InputDecoration(
                            labelText: 'User Type',
                            labelStyle: TextStyle(fontSize: 18),
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none),
                        hint: Text(''),
                        onChanged: (value) {
                          setState(() {
                            print('new value : $value');
                            _selectedUser = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
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
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppConstants.textMediumSize,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already Registered?'),
                        FlatButton(
                          onPressed: () {
                            AppRoutes.setFirst(context, '/');
                          },
                          child: Text(
                            'Login Here',
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
    if (_fullNameController.text.trim().isEmpty) {
      Utility.showToast('Full name is required');
      _fullName.requestFocus();
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      Utility.showToast('Email Id is required');
      _email.requestFocus();
      return;
    }

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text.trim());
    if (!emailValid) {
      Utility.showToast('Email Id is not valid');
      _email.requestFocus();
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      Utility.showToast('Password is required');
      _password.requestFocus();
      return;
    }

    if (_mobileController.text.trim().isEmpty) {
      Utility.showToast('Mobile number is required');
      _mobile.requestFocus();
      return;
    }

    var networkAvailable = Utility.isNetworkAvailable();
    if (networkAvailable != null) {
      networkAvailable.then((isNetworkReady) {
        if (isNetworkReady) {
          var loginToken = _apiCalling.setUserRegistration(
              name: _fullNameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
              mobile: _mobileController.text.trim(),
              roleId: _selectedUser.value);
          if (loginToken != null) {
            loginToken.then((jsonResponse) {
              if (jsonResponse != null && jsonResponse.isNotEmpty) {
                final Map parsed = json.decode(jsonResponse);
                var statusResponse = StatusResponse.map(parsed);
                if (statusResponse.success) {
                  showAlertDialog(context);
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

  void showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("LOGIN"),
      onPressed: () {
        AppRoutes.setFirst(context, '/');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Registration'),
      content: Text('User registration successful, please login'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
