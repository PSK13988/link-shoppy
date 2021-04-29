import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/order_list_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/screens/order_detail_screen.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  APICalling _apiCalling = APICalling();
  List<Order> _orderList = [];

  @override
  void initState() {
    _callGetUserFolderInfo();
    super.initState();
  }

  Future<void> _callGetUserFolderInfo() async {
    if (AppConstants.userId != null && AppConstants.userId.isNotEmpty) {
      print('Calling api from static data structure');
      var networkAvailable = Utility.isNetworkAvailable();
      if (networkAvailable != null) {
        networkAvailable.then((isNetworkReady) {
          if (isNetworkReady) {
            _callApi(userId: AppConstants.userId);
          } else {
            Utility.showToast(AppConstants.MSG_INTERNET_NOT);
          }
        });
      } else {
        Utility.showToast(AppConstants.MSG_NETWORK_CHECK);
      }
    } else {
      // fetching data from app prefs
      print('getting data from app prefs and resetting comman data structure');
      //var fAgreementNo = AppSharedPreference.getAgreementNo();
      var fUserId = AppSharedPreference.getUserId();
      //if (fAgreementNo != null) {
      //fAgreementNo.then((agrno) {
      //if (agrno != null && agrno.isNotEmpty) {
      if (fUserId != null) {
        fUserId.then((userId) {
          if (userId != null && userId.isNotEmpty) {
            // if (fPassword != null) {
            //fPassword.then((password) {
            // if (password != null && password.isNotEmpty) {
            var networkAvailable = Utility.isNetworkAvailable();
            if (networkAvailable != null) {
              networkAvailable.then((isNetworkReady) {
                if (isNetworkReady) {
                  _callApi(userId: userId);
                  setState(() {
                    AppConstants.userId = userId;
                  });
                } else {
                  Utility.showToast(AppConstants.MSG_INTERNET_NOT);
                }
              });
            } else {
              Utility.showToast(AppConstants.MSG_NETWORK_CHECK);
            }
            //  }
            //});
            //}
          }
        });
      }
      //}
      //});
      //}
    }
  }

  void _callApi({String userId}) {
    var userFolderInfo = _apiCalling.getOrders(userId: userId);
    if (userFolderInfo != null) {
      userFolderInfo.then((response) {
        if (response != null && response.isNotEmpty) {
          final Map parsed = json.decode(response);
          var orderListResponse = OrderListResponse.fromJson(parsed);
          if (orderListResponse.success) {
            setState(() {
              _orderList = orderListResponse.users;
            });
          } else {
            Utility.showToast('Orders not available');
          }
        } else {
          Utility.showToast(AppConstants.MSG_UNKNOWN_ERROR);
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
              backgroundColor: AppConstants.colorPrimary,
              title: Text(
                'My Orders',
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
                )
              ]),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: _callGetUserFolderInfo,
              child: ListView.builder(
                  itemCount: _orderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 0),
                        child: ListTile(
                          onTap: () {
                            AppRoutes.push(
                                context, OrderDetailScreen(_orderList[index]));
                          },
                          leading: Icon(
                            Icons.add_shopping_cart,
                            size: 45.0,
                            color: AppConstants.colorPrimary,
                          ),
                          title: Text(
                            '${_orderList[index].contactName} : ${_orderList[index].contactNumber}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppConstants.textTitleColor,
                                fontSize: AppConstants.textTitleSize,
                                fontWeight: AppConstants.textTitleWeight),
                          ),
                          subtitle: Text(
                              'Order No: ${_orderList[index].orderNumber}',
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppConstants.textSubTitleColor,
                                  fontSize: AppConstants.textSubTitleSize,
                                  fontWeight: AppConstants.textSubTitleWeight)),
//                          trailing: Text('(${_orderList[index]})'),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
