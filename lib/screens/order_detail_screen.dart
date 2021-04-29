import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/order_detail_response.dart';
import 'package:app/models/pojos/order_list_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order _order;
  OrderDetailScreen(this._order);
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState(_order);
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  Order _order;
  _OrderDetailScreenState(this._order);
  APICalling _apiCalling = APICalling();
  List<OrderDetail> _orderDetailList = [];

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
            _callApi(
              userId: AppConstants.userId,
              orderId: _order.id,
            );
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
      //var fPassword = AppSharedPreference.getPassword();
      //if (fAgreementNo != null) {
      //fAgreementNo.then((agrno) {
      //if (agrno != null && agrno.isNotEmpty) {
      if (fUserId != null) {
        fUserId.then((userId) {
          if (userId != null && userId.isNotEmpty) {
            //if (fPassword != null) {
            //fPassword.then((password) {
            //  if (password != null && password.isNotEmpty) {
            var networkAvailable = Utility.isNetworkAvailable();
            if (networkAvailable != null) {
              networkAvailable.then((isNetworkReady) {
                if (isNetworkReady) {
                  _callApi(userId: userId, orderId: _order.id);
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
            //}
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

  void _callApi({String userId, String orderId}) {
    var userFolderInfo =
        _apiCalling.getOrderDetails(userId: userId, orderId: orderId);
    if (userFolderInfo != null) {
      userFolderInfo.then((response) {
        if (response != null && response.isNotEmpty) {
          final Map parsed = json.decode(response);
          var orderDetailResponse = OrderDetailResponse.fromJson(parsed);
          if (orderDetailResponse.success) {
            setState(() {
              _orderDetailList = orderDetailResponse.users;
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
                'Order Details',
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
                  itemCount:
                      _orderDetailList == null ? 0 : _orderDetailList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 0),
                        child: ListTile(
                          onTap: () {
                            //AppRoutes.push(context, OrderDetailScreen());
                          },
                          leading: Icon(
                            Icons.folder,
                            size: 45.0,
                            color: AppConstants.colorPrimary,
                          ),
                          title: Text(
                            _orderDetailList[index].itemName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppConstants.textTitleColor,
                                fontSize: AppConstants.textTitleSize,
                                fontWeight: AppConstants.textTitleWeight),
                          ),
                          subtitle: Text(
                              'Price: ${_orderDetailList[index].price} Quantity: ${_orderDetailList[index].quantity}',
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppConstants.textSubTitleColor,
                                  fontSize: AppConstants.textSubTitleSize,
                                  fontWeight: AppConstants.textSubTitleWeight)),
                          //trailing: Text('(${_orderList[index]})'),
                          //),
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
