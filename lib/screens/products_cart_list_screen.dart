import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/customviews/count_icon.dart';
import 'package:app/models/pojos/order_product_request.dart';
import 'package:app/models/pojos/product_list_response.dart';
import 'package:app/models/pojos/shop_list_response.dart';
import 'package:app/models/pojos/sub_category_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class ProductCartListScreen extends StatefulWidget {
  final List<Products> selectedItems;
  final Shops shop;

  ProductCartListScreen(this.selectedItems, this.shop);

  @override
  _ProductCartListScreenState createState() => _ProductCartListScreenState(selectedItems, shop);
}

class _ProductCartListScreenState extends State<ProductCartListScreen> {
  List<Products> selectedItems;
  Shops shop;

  _ProductCartListScreenState(this.selectedItems, this.shop);

  List<String> quantity = ['kg', 'g', 'ltr', 'ml', 'unit'];

  APICalling _apiCalling = APICalling();

//  List<Items> selectedItems = [];
//  List<Category> _subCategory = [];
//  Category _selectedCategory;
  List<Products> _allSelectedItems = [];

  /* List<String> _subCategory = ['All', 'Oil', 'Rice'];
  String _selectedCategory = 'All';*/

  @override
  void initState() {
    /* if (response != null && response.isNotEmpty) {
      final Map parsed = json.decode(response);
      var jaguListResponse = JaguListResponse.fromJson(parsed);
      setState(() {
        items = jaguListResponse.items;
      });
      print('jagu:$items');
    }*/
    selectedItems.forEach((element) {
      print(element.selectedUnit);
      print(element.enteredQuantity);
      print('------------');
    });

    setState(() {
      _allSelectedItems = selectedItems;
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
          appBar: AppBar(
            backgroundColor: AppConstants.colorPrimary,
            title: Text(
              'Final products',
              style: TextStyle(
                color: AppConstants.appBarTitleColor,
                letterSpacing: 1.2,
                fontSize: 19.0,
              ),
            ),
            iconTheme: new IconThemeData(color: AppConstants.iconColor),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _allSelectedItems == null ? 0 : _allSelectedItems.length,
                        itemBuilder: (context, index) {
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
                                            _allSelectedItems[index].itemName,
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
                                        initialValue: _allSelectedItems[index].enteredQuantity,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Quantity',
                                          labelText: 'Quantity',
                                        ),
                                        style: TextStyle(fontSize: AppConstants.textMediumSize),
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
//                            focusNode: _productCategory,
//                            controller: _productCategoryController,
                                        onFieldSubmitted: (v) {
                                          FocusScope.of(context).nextFocus();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(_allSelectedItems[index].selectedUnit == null
                                              ? ''
                                              : _allSelectedItems[index].selectedUnit.unitName),
                                        )),
                                    /*Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          child: Icon(Icons.delete_outline),
                                          onTap: () {
//                                            setState(() {
//                                              _allSelectedItems.remove(_allSelectedItems[index]);
//                                            });
                                          },
                                        )),*/
                                    /*Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 4, 2, 4),
                                        child: Container(
                                          height: 60,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1.0,
                                                  style: BorderStyle.solid,
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          ),
                                          child:
                                              DropdownButtonFormField<String>(
                                            isExpanded: true,
                                            value: selectedValues[
                                                items[index].productId],
                                            items: quantity
                                                .map((label) =>
                                                    DropdownMenuItem<String>(
                                                      child: Text(
                                                        label,
                                                        style: TextStyle(
                                                            fontSize: AppConstants
                                                                .textMediumSize),
                                                      ),
                                                      value: label,
                                                    ))
                                                .toList(),
                                            decoration: InputDecoration(
                                                labelText: 'Unit',
                                                labelStyle: TextStyle(
                                                    fontSize: AppConstants
                                                        .textMediumSize),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: InputBorder.none),
                                            hint: Text(''),
                                            onChanged: (value) {
                                              setState(() {
                                                print('new value : $value');
                                                selectedValues[items[index]
                                                    .productId] = value;
                                                print(
                                                    selectedValues.toString());
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),*/
                                    /*Expanded(
                                      flex: 1,
                                      child: Checkbox(
                                          value: checkBoxValue[
                                              items[index].productId],
                                          activeColor:
                                              AppConstants.colorPrimary,
                                          onChanged: (newValue) {
                                            print('newValue: $newValue');
                                            setState(() {
                                              checkBoxValue[items[index]
                                                  .productId] = newValue;
                                              print(checkBoxValue.toString());
                                            });
                                            if (newValue) {
                                              bool exists = selectedItems
                                                  .contains(items[index]);
                                              if (!exists) {
                                                selectedItems.add(items[index]);
                                                print(selectedItems.toString());
                                              }
                                            } else {
                                              selectedItems
                                                  .remove(items[index]);
                                              print(selectedItems.toString());
                                            }
                                          }),
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        List<Items> list = [];

                        _allSelectedItems.forEach((element) {
                          var items = Items(
                              productId: element.id,
                              quantity: element.enteredQuantity,
                              price: element.itemPrice,
                              productUnitId: element.selectedUnit.id);
                          list.add(items);
                        });

                        OrderProductRequest orderProductRequest = OrderProductRequest(items: list.reversed.toList());
                        print(json.encode(orderProductRequest));
                        _apiCalling.setOrderGenerate(
                            userId: selectedItems[0].userId,
                            shopId: shop.shopId,
                            items: json.encode(orderProductRequest));
                      },
                      child: Text(
                        'Generate Order',
                        style: TextStyle(fontSize: 18, letterSpacing: 1.2),
                      ),
                    ),
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
