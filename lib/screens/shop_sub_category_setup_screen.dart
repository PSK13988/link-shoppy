import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/status_response.dart';
import 'package:app/models/pojos/sub_category_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/screens/add_subcategory_screen.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class ShopSubCategorySetupScreen extends StatefulWidget {
  @override
  _ShopSubCategorySetupScreenState createState() =>
      _ShopSubCategorySetupScreenState();
}

class _ShopSubCategorySetupScreenState
    extends State<ShopSubCategorySetupScreen> {
  APICalling _apiCalling = APICalling();
  final FocusNode _productName = FocusNode();
  final FocusNode _productPrice = FocusNode();
  final FocusNode _productQuantity = FocusNode();
  final FocusNode _other = FocusNode();

  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _otherController = TextEditingController();
  final tripNameEditingController = TextEditingController();
  List<Category> _subCategory = [];
  Category _selectedCategory;

  @override
  void initState() {
    var fUserId = AppSharedPreference.getUserId();
    var fCategoryId = AppSharedPreference.getCategoryId();
    if (fUserId != null) {
      fUserId.then((userId) {
        if (userId != null && userId.isNotEmpty) {
          print('userId : $userId');

          if (fCategoryId != null) {
            fCategoryId.then((categoryId) {
              if (categoryId != null && categoryId.isNotEmpty) {
                print('categoryId : $categoryId');
                setState(() {
                  AppConstants.userId = userId;
                  AppConstants.categoryId = categoryId;
                });
                getSubCategoryList(userId: userId, categoryId: categoryId);
              }
            });
          }
        }
      });
    }

    super.initState();
  }

  void getSubCategoryList({String userId, String categoryId}) {
    var subCategoryList =
        _apiCalling.getSubCategoryList(userId: userId, categoryId: categoryId);
    if (subCategoryList != null) {
      subCategoryList.then((response) {
        if (response != null && response.isNotEmpty) {
          final Map parsed = json.decode(response);
          var subCategoryResponse = SubCategoryResponse.map(parsed);
          if (subCategoryResponse.success) {
            if (subCategoryResponse.category != null &&
                subCategoryResponse.category.length > 0) {
              setState(() {
                _subCategory = subCategoryResponse.category;
              });
            } else {
              Utility.showToast('Sub category not available');
            }
          } else {
            Utility.showToast('Sub category not found');
          }
        }
      });
    }
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
              //title: Text('Shop sub-category setup'),
              backgroundColor: AppConstants.colorPrimary,
              title: Text(
                'Shop sub-category setup',
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                        child: DropdownButtonFormField<Category>(
                          isExpanded: true,
                          value: _selectedCategory,
                          items: _subCategory
                              .map((label) => DropdownMenuItem<Category>(
                                    child: Text(label.subCategoryName),
                                    value: label,
                                  ))
                              .toList(),
                          decoration: InputDecoration(
                              labelText: 'Select Sub Category',
                              labelStyle: TextStyle(fontSize: 18),
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none),
                          hint: Text(''),
                          onChanged: (value) {
                            setState(() {
                              print('new value : $value');
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Item Name',
                                labelText: 'Name',
                              ),
                              style: TextStyle(
                                  fontSize: AppConstants.textMediumSize),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              focusNode: _productName,
                              controller: _productNameController,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Item Price',
                                labelText: 'Price',
                              ),
                              style: TextStyle(
                                  fontSize: AppConstants.textMediumSize),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              focusNode: _productPrice,
                              controller: _productPriceController,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Item Quantity',
                                labelText: 'Quantity',
                              ),
                              style: TextStyle(
                                  fontSize: AppConstants.textMediumSize),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              focusNode: _productQuantity,
                              controller: _productQuantityController,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Other',
                                labelText: 'Other',
                              ),
                              style: TextStyle(
                                  fontSize: AppConstants.textMediumSize),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              focusNode: _other,
                              controller: _otherController,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ],
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
                              side:
                                  BorderSide(color: AppConstants.colorPrimary)),
                          onPressed: () {
                            //Utility.showToast('Under development');
                            validateForm();
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppConstants.textMediumSize,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()),
                );*/
                _showDialog();
                //AppRoutes.push(context, AddSubCategoryScreen());
                //Utility.showToast('Under development');
              },
              label: Text('Sub Category'),
              icon: Icon(Icons.add_circle),
              backgroundColor: Colors.pink,
            ));
      },
    );
  }

  void validateForm() {
    if (AppConstants.userId == null) {
      Utility.showToast('User data not available');
      return;
    }

    if (AppConstants.categoryId == null) {
      Utility.showToast('Category not available');
      return;
    }

    if (_selectedCategory == null) {
      Utility.showToast('Please select sub category');
      return;
    }

    if (_productNameController.text.trim().isEmpty) {
      Utility.showToast('Please enter product name');
      _productName.requestFocus();
      return;
    }

    if (_productPriceController.text.trim().isEmpty) {
      Utility.showToast('Please enter product price');
      _productPrice.requestFocus();
      return;
    }

    if (_productQuantityController.text.trim().isEmpty) {
      Utility.showToast('Please enter product quantity');
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
              subCategoryId: _selectedCategory.id,
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
                  Utility.showToast('Product Added Successfully');
                  AppSharedPreference.setShopVerified(true);
                  AppRoutes.setFirst(context, '/home');
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text('Sub Category'),
            ],
          ),
          content: TextField(
            controller: tripNameEditingController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                hintText: 'Please enter sub category',
                border: OutlineInputBorder(),
                labelText: 'Sub category'),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  onPressed: () {
                    var setAddSubCategory = _apiCalling.setAddSubCategory(
                        userId: AppConstants.userId,
                        categoryId: AppConstants.categoryId,
                        subCategoryName: tripNameEditingController.text.trim());
                    if (setAddSubCategory != null) {
                      setAddSubCategory.then((jsonResponse) {
                        if (jsonResponse != null && jsonResponse.isNotEmpty) {
                          final Map parsed = json.decode(jsonResponse);
                          var statusResponse = StatusResponse.map(parsed);

                          if (statusResponse.success) {
                            AppRoutes.pop(context);
                            Utility.showToast(
                                'Sub category added successfully');
                            getSubCategoryList(
                                userId: AppConstants.userId,
                                categoryId: AppConstants.categoryId);
                          } else {
                            Utility.showToast(statusResponse.message);
                          }
                        } else {
                          Utility.showToast(AppConstants.MSG_UNKNOWN_ERROR);
                        }
                      });
                    }
                  },
                  child: new Text("SAVE"),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
