import 'dart:convert';

import 'package:app/models/pojos/jagu_list_response.dart';
import 'package:app/models/pojos/sub_category_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class HelloScreen extends StatefulWidget {
  @override
  _HelloScreenState createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  List<String> quantity = ['kg', 'g', 'ltr', 'ml'];
  Map<String, String> selectedValues = {};
  Map<String, bool> checkBoxValue = {};
  String response =
      '{"items":[{"product_id":"1","product_name":"ParlyG","price":"40"},{"product_id":"2","product_name":"Britania","price":"30"},{"product_id":"3","product_name":"Monaco","price":"50"},{"product_id":"4","product_name":"Monaco 1","price":"50"}]}';

  List<Items> items = [];
  List<Category> _subCategory = [];
  Category _selectedCategory;

  @override
  void initState() {
    if (response != null && response.isNotEmpty) {
      final Map parsed = json.decode(response);
      var jaguListResponse = JaguListResponse.fromJson(parsed);
      setState(() {
        items = jaguListResponse.items;
      });
      print('jagu:$items');
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
                'Products',
                style: TextStyle(
                  color: AppConstants.appBarTitleColor,
                  letterSpacing: 1.2,
                  fontSize: 19.0,
                ),
              ),
              iconTheme: new IconThemeData(color: AppConstants.iconColor),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: AppConstants.iconColor,
                  ),
                  onPressed: () {
                    //Navigator.pop(context);
                    Utility.showToast('Search');
                  },
                ),
              ]),
          body: Padding(
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
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Colors.grey),
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
                          setState(() {
                            print('new value : $value');
                            _selectedCategory = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: items == null ? 0 : items.length,
                        itemBuilder: (context, index) {
                          if (checkBoxValue[items[index].productId] != null) {
                            if (checkBoxValue[items[index].productId] != true) {
                              checkBoxValue[items[index].productId] = false;
                            }
                          } else {
                            checkBoxValue[items[index].productId] = false;
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
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 4, 8, 4),
                                          child: Text(
                                            items[index].productName,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: AppConstants
                                                    .textMediumSize),
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
                                        style: TextStyle(
                                            fontSize:
                                                AppConstants.textMediumSize),
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
                                    ),
                                    Expanded(
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
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => ShopSubCategorySetupScreen()),
//              );
            },
            label: Text('Add Photo '),
            icon: Icon(Icons.add_a_photo),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
}
