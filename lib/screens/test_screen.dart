import 'dart:convert';

import 'package:app/customviews/count_icon.dart';
import 'package:app/models/pojos/jagu_list_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String response =
      '{"items":[{"product_id":"1","product_name":"ParlyG","price":"40"},{"product_id":"2","product_name":"Britania","price":"30"},{"product_id":"3","product_name":"Monaco","price":"50"},{"product_id":"4","product_name":"Monaco 1","price":"50"},{"product_id":"5","product_name":"Crack Jack","price":"30"},{"product_id":"6","product_name":"Hide & Seek","price":"60"},{"product_id":"7","product_name":"Oreo","price":"50"}]}';
  List<Items> items = [];
  List<String> unit = ['kg', 'g', 'l', 'ml'];
  Map<String, String> selectedUnit = {};
  @override
  void initState() {
    if (response != null && response.isNotEmpty) {
      final Map parsed = json.decode(response);
      var jaguListResponse = JaguListResponse.fromJson(parsed);
      setState(() {
        items = jaguListResponse.items;
      });
      print('jagu:$items');
    } //    _passwordVisible = false;
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
            title: Text('Kuchbhi'),
            actions: [
              CountIcon(
                text: 'Inbox',
                iconData: Icons.notifications,
                notificationCount: 11,
                onTap: () {},
              ),
            ],
          ),
          body: ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 90,
                  child: Card(
                    elevation: 5.0,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            items[index].productName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppConstants.textTitleColor,
                                fontSize: AppConstants.textTitleSize,
                                fontWeight: AppConstants.textTitleWeight),
                          ),
                        ),
                        Container(
                          width: 70,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'qty',
                              labelText: 'Qty',
                            ),
                            style: TextStyle(
                                fontSize: AppConstants.textMediumSize),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 70,
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
                          child: DropdownButtonFormField<String>(
                            isExpanded: false,
                            value: selectedUnit[items[index].productId],
                            items: unit
                                .map((label) => DropdownMenuItem<String>(
                                      child: Text(label),
                                      value: label,
                                    ))
                                .toList(),
                            decoration: InputDecoration(
                                labelText: 'Unit',
                                labelStyle: TextStyle(fontSize: 18),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none),
                            hint: Text(''),
                            onChanged: (value) {
                              setState(() {
                                print('new value : $value');
                                selectedUnit[items[index].productId] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
