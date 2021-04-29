import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/status_response.dart';
import 'package:app/models/pojos/sub_category_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final FocusNode _productCategory = FocusNode();
  final FocusNode _productName = FocusNode();
  final FocusNode _productPrice = FocusNode();
  final FocusNode _productQuantity = FocusNode();
  final FocusNode _other = FocusNode();
  final _productCategoryController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _otherController = TextEditingController();

  APICalling _apiCalling = APICalling();

  @override
  void initState() {
    var subCategoryList = _apiCalling.getSubCategoryList(
        userId: AppConstants.userId, categoryId: AppConstants.categoryId);
    if (subCategoryList != null) {
      subCategoryList.then((jsonResponse) {
        if (jsonResponse != null && jsonResponse.isNotEmpty) {
          final Map parsed = json.decode(jsonResponse);
          var subCategoryResponse = SubCategoryResponse.map(parsed);
          if (subCategoryResponse.success) {
            print(subCategoryResponse.category.toString());
          } else {
            print('Category not available');
          }
        }
      });
    }

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
          appBar: AppBar(
            backgroundColor: AppConstants.colorPrimary,
            title: Text(
              'Add Product',
              style: TextStyle(
                color: AppConstants.appBarTitleColor,
                letterSpacing: 1,
                fontSize: 19.0,
              ),
            ),
            iconTheme: new IconThemeData(color: AppConstants.iconColor),
            /*actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.brush,
                  color: AppConstants.iconColor,
                ),
                onPressed: () {
                  showThemeChooser();
                },
              ),
            ],*/
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Please select product category',
                        labelText: 'Please select product category',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _productCategory,
                      controller: _productCategoryController,
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
                        hintText: 'Product name',
                        labelText: 'Product name',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _productName,
                      controller: _productNameController,
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
                        hintText: 'Product price',
                        labelText: 'Product price',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _productPrice,
                      controller: _productPriceController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Product quantity',
                        labelText: 'Product quantity',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _productQuantity,
                      controller: _productQuantityController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Other',
                        labelText: 'Other',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      focusNode: _other,
                      controller: _otherController,
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
                          'ADD PRODUCT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppConstants.textMediumSize,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
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
    if (_productCategoryController.text.trim().isEmpty) {
      Utility.showToast('Product category is required');
      _productCategory.requestFocus();
      return;
    }
    if (_productNameController.text.trim().isEmpty) {
      Utility.showToast('Product name is required');
      _productName.requestFocus();
      return;
    }
    if (_productPriceController.text.trim().isEmpty) {
      Utility.showToast('Product price is required');
      _productPrice.requestFocus();
      return;
    }
    if (_productQuantityController.text.trim().isEmpty) {
      Utility.showToast('Product quantity is required');
      _productQuantity.requestFocus();
      return;
    }

    var networkAvailable = Utility.isNetworkAvailable();
    if (networkAvailable != null) {
      networkAvailable.then((isNetworkReady) {
        if (isNetworkReady) {
          var setAddProduct = _apiCalling.setAddProduct(
              userId: AppConstants.userId,
              categoryId: AppConstants.categoryId,
              subCategoryId: _productCategoryController.text.trim(),
              itemName: _productNameController.text.trim(),
              itemPrice: _productPriceController.text.trim(),
              itemQuantity: _productQuantityController.text.trim(),
              other: _otherController.text.trim());

          if (setAddProduct != null) {
            setAddProduct.then((jsonResponse) {
              if (jsonResponse != null && jsonResponse.isNotEmpty) {
                final Map parsed = json.decode(jsonResponse);
                var statusResponse = StatusResponse.map(parsed);
                if (statusResponse.success) {
                  Utility.showToast('Product added successfully');
                } else {
                  Utility.showToast(statusResponse.message);
                }
              }
            });
          }

//          var loginToken = _apiCalling.getLogin(
//              email: _emailController.text.trim(),
//              password: _passwordController.text.trim());
//          if (loginToken != null) {
//            loginToken.then((jsonResponse) {
//              if (jsonResponse != null && jsonResponse.isNotEmpty) {
//                final Map parsed = json.decode(jsonResponse);
//                var loginResponse = LoginResponse.map(parsed);
//                if (loginResponse.success) {
//                  Utility.showToast('Login Successful');
//                  AppSharedPreference.setEmail(loginResponse.email);
//                  AppSharedPreference.setJwtToken(loginResponse.jwt);
//                  AppSharedPreference.setRefreshToken(loginResponse.refresh);
//                  AppSharedPreference.setUserId(loginResponse.userData.id);
//                  //AppSharedPreference.setUserData(loginResponse.userData);
//                  // Setting firstTimeLaunch flag
//                  AppSharedPreference.setFirstTimeLaunch(true);
//                  // Redirect to Home
//                  if (loginResponse.shopSetup) {
//                    AppSharedPreference.setShopVerified(true);
//                    AppRoutes.setFirst(context, '/home');
//                  } else {
//                    AppRoutes.setFirst(context, '/shopSetup');
//                  }
//                } else {
//                  Utility.showToast(
//                      'Login failed please enter valid credentials');
//                }
//              } else {
//                Utility.showToast(AppConstants.MSG_UNKNOWN_ERROR);
//              }
//            });
//          }
        } else {
          Utility.showToast(AppConstants.MSG_INTERNET_NOT);
        }
      });
    } else {
      Utility.showToast(AppConstants.MSG_NETWORK_CHECK);
    }
  }
}
