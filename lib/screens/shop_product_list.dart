import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/customviews/count_icon.dart';
import 'package:app/models/pojos/product_list_response.dart';
import 'package:app/models/pojos/shop_list_response.dart';
import 'package:app/models/pojos/sub_category_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/screens/products_cart_list_screen.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class ShopProductList extends StatefulWidget {
  final Shops shop;

  ShopProductList(this.shop);

  @override
  _ShopProductListState createState() => _ShopProductListState(shop);
}

class _ShopProductListState extends State<ShopProductList> {
  Shops shop;

  _ShopProductListState(this.shop);

  APICalling _apiCalling = APICalling();
  List<String> quantity = ['kg', 'g', 'ltr', 'ml', 'unit'];
  Map<String, Type> selectedValues = {};
  Map<String, String> enteredValues = {};
  Map<String, bool> checkBoxValue = {};

  List<Products> _productList = [];
  List<Type> _typeList = [];

//  List<Products> _allProductList = [];
  List<Products> selectedItems = [];

  List<Category> _subCategory = [];
  Category _selectedCategory;

  @override
  void initState() {
    _initView();
    super.initState();
  }

  void _initView() {
    var fCategoryId = AppSharedPreference.getCategoryId();
    if (fCategoryId != null) {
      fCategoryId.then((categoryId) {
        AppConstants.categoryId = categoryId;
        getSubCategoryList(userId: shop.userId, categoryId: categoryId);

        var orderProductList =
            _apiCalling.getOrderProductList(userId: shop.userId, categoryId: categoryId, subCategoryId: '');
        if (orderProductList != null) {
          orderProductList.then((response) {
            if (response != null && response.isNotEmpty) {
              final Map parsed = json.decode(response);
              var productListResponse = ProductListResponse.map(parsed);

              if (productListResponse.success) {
                setState(() {
                  _productList = productListResponse.users.toList();
                  _typeList = productListResponse.type.toList();
//                  _allProductList = _productList;
                });
              } else {
                Utility.showAlertWithMessage(context, 'No Products Available');
              }
            } else {
              Utility.showToast(AppConstants.MSG_UNKNOWN_ERROR);
            }
          });
        }
      });
    }
  }

  void getSubCategoryList({String userId, String categoryId}) {
    var subCategoryList = _apiCalling.getSubCategoryList(userId: userId, categoryId: categoryId);
    if (subCategoryList != null) {
      subCategoryList.then((response) {
        if (response != null && response.isNotEmpty) {
          final Map parsed = json.decode(response);
          var subCategoryResponse = SubCategoryResponse.map(parsed);
          if (subCategoryResponse.success) {
            if (subCategoryResponse.category != null && subCategoryResponse.category.length > 0) {
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: AppConstants.colorPrimary,
              title: Text(
                '${shop.shopName} products',
                style: TextStyle(
                  color: AppConstants.appBarTitleColor,
                  letterSpacing: 1.2,
                  fontSize: 19.0,
                ),
              ),
              iconTheme: new IconThemeData(color: AppConstants.iconColor),
              actions: <Widget>[
                CountIcon(
                  text: '',
                  iconData: Icons.shopping_cart,
                  notificationCount: selectedItems.length,
                  onTap: () {
                    if (selectedItems.length > 0) {
                      FocusScope.of(context).unfocus();
                      AppRoutes.push(context, ProductCartListScreen(selectedItems, shop));
                    } else {
                      Utility.showToast('Cart is empty please add some items');
                    }
                  },
                ),
              ]),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                              labelText: 'Sub Category',
                              labelStyle: TextStyle(fontSize: 18),
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none),
                          hint: Text(''),
                          onChanged: (value) {
                            List<Products> productList = _productList.where((i) => i.id == value.id).toList();
                            setState(() {
                              print('new value : ${value.categoryId}');
                              print('new productList : $productList');
                              _selectedCategory = value;
                              _productList = productList;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 7,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _productList == null ? 0 : _productList.length,
                        itemBuilder: (context, index) {
                          //selectedValues[_productList[index].id] = 'Kg';
                          if (checkBoxValue[_productList[index].id] != null) {
                            if (checkBoxValue[_productList[index].id] != true) {
                              checkBoxValue[_productList[index].id] = false;
                            }
                          } else {
                            checkBoxValue[_productList[index].id] = false;
                          }

                          return GestureDetector(
                            onTap: () {
                              print('Row clicked');
                            },
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 4, 8, 4),
                                          child: Text(
                                            _productList[index].itemName,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.grey[800], fontSize: AppConstants.textMediumSize),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Quantity',
                                          labelText: 'Quantity',
                                        ),
                                        style: TextStyle(fontSize: AppConstants.textMediumSize),
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
//                            focusNode: _productCategory,
                                        //controller: enteredValues[_productList[index].id],
                                        onChanged: (value) {
                                          setState(() {
                                            if (value != null && value.isNotEmpty) {
                                              checkBoxValue[_productList[index].id] = true;
                                              bool exists = selectedItems.contains(_productList[index]);
                                              if (!exists) {
                                                selectedItems.add(_productList[index]);
                                              } else {
                                                _productList[index].enteredQuantity = value;
                                              }
                                            } else {
                                              checkBoxValue[_productList[index].id] = false;
                                              selectedValues[_productList[index].id] = null;
                                              selectedItems.remove(_productList[index]);
                                            }
                                            _productList[index].enteredQuantity = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 4, 2, 4),
                                        child: Container(
                                          height: 60,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side:
                                                  BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                            ),
                                          ),
                                          child: DropdownButtonFormField<Type>(
                                            isExpanded: true,
                                            value: selectedValues[_productList[index].id],
                                            items: _typeList
                                                .map((label) => DropdownMenuItem<Type>(
                                                      child: Text(
                                                        label.unitName,
                                                        style: TextStyle(fontSize: AppConstants.textMediumSize),
                                                      ),
                                                      value: label,
                                                    ))
                                                .toList(),
                                            decoration: InputDecoration(
                                                labelText: 'Unit',
                                                labelStyle: TextStyle(fontSize: AppConstants.textMediumSize),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: InputBorder.none),
                                            hint: Text(''),
                                            onChanged: (value) {
                                              setState(() {
                                                print('new value : $value');
                                                if (value != null) {
                                                  checkBoxValue[_productList[index].id] = true;
                                                  bool exists = selectedItems.contains(_productList[index]);
                                                  if (!exists) {
                                                    selectedItems.add(_productList[index]);
                                                  } else {
                                                    _productList[index].selectedUnit = value;
                                                  }
                                                } else {
                                                  checkBoxValue[_productList[index].id] = false;
                                                  selectedItems.remove(_productList[index]);
                                                }
                                                selectedValues[_productList[index].id] = value;
                                                _productList[index].selectedUnit = value;
                                                print(selectedValues.toString());
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Checkbox(
                                          value: checkBoxValue[_productList[index].id],
                                          activeColor: AppConstants.colorPrimary,
                                          onChanged: (newValue) {
                                            print('newValue: $newValue');
                                            setState(() {
                                              checkBoxValue[_productList[index].id] = newValue;
                                              print(checkBoxValue.toString());
                                            });
                                            if (newValue) {
                                              bool exists = selectedItems.contains(_productList[index]);
                                              if (!exists) {
                                                _productList[index].enteredQuantity =
                                                    enteredValues[_productList[index].id];
                                                _productList[index].selectedUnit =
                                                    selectedValues[_productList[index].id];
                                                selectedItems.add(_productList[index]);
                                                print(selectedItems.toString());
                                              }
                                            } else {
                                              selectedItems.remove(_productList[index]);
                                              print(selectedItems.toString());
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
