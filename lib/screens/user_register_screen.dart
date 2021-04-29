import 'package:app/apis/api_services.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class UserRegisterScreen extends StatefulWidget {
  @override
  _UserRegisterScreenState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
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
                      height: 90,
                      width: 90,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      'User Registration',
                      style: TextStyle(fontSize: 16),
                    )),
                    SizedBox(
                      height: 20,
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
                          //validateForm();
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
                    SizedBox(
                      height: 10,
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
}
