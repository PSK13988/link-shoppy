import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/product_list_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/screens/order_list_screen.dart';
import 'package:app/screens/shop_sub_category_setup_screen.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _version;
  String _buildNumber;
  int _currentTheme;

  //String _email;
  String _userEmail;
  APICalling _apiCalling = APICalling();
  List<Products> _productList = [];

  /*final items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8'
  ];*/

  @override
  void initState() {
    //AppSharedPreference.setCategoryId('2');

    var fCurrentTheme = AppSharedPreference.getCurrentTheme();
    fCurrentTheme.then((value) {
      if (value != null) {
        print('Code : $value');
        _updateTheme(value);
      }
    });

    var jwtToken = AppSharedPreference.getJwtToken();
    if (jwtToken != null) {
      jwtToken.then((jwt) {
        if (jwt != null && jwt.isNotEmpty) {
          setState(() {
            AppConstants.jwt = jwt;
          });
        }
      });
    }

    var fUserId = AppSharedPreference.getUserId();
    if (fUserId != null) {
      fUserId.then((userId) {
        if (userId != null && userId.isNotEmpty) {
          setState(() {
            AppConstants.userId = userId;
          });
        }
      });
    }

    var fCategoryId = AppSharedPreference.getCategoryId();
    if (fCategoryId != null) {
      fCategoryId.then((categoryId) {
        if (categoryId != null && categoryId.isNotEmpty) {
          setState(() {
            AppConstants.categoryId = categoryId;
          });
        }
      });
    }

    var fEmail = AppSharedPreference.getEmail();
    if (fEmail != null) {
      fEmail.then((email) {
        if (email != null && email.isNotEmpty) {
          setState(() {
            _userEmail = email;
          });
        }
      });
    }

    _callGetProductList();
    _getAppPackageInfo();

    super.initState();
  }

//  @override
//  void initState() {
//    _callGetExplorerSearchDoc();
//    super.initState();
//  }

  Future<void> _callGetProductList() async {
    if (AppConstants.userId != null &&
        AppConstants.userId.isNotEmpty &&
        AppConstants.categoryId != null &&
        AppConstants.categoryId.isNotEmpty) {
      // Calling api from static data structure
      print('Calling api from static data structure');
      var networkAvailable = Utility.isNetworkAvailable();
      if (networkAvailable != null) {
        networkAvailable.then((isNetworkReady) {
          if (isNetworkReady) {
            _callApiGetProductList(userId: AppConstants.userId, categoryId: AppConstants.categoryId, subCategoryId: '');
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
      var fAgreementNo = AppSharedPreference.getUserId();
      var fEmail = AppSharedPreference.getCategoryId();
      //var fPassword = AppSharedPreference.getPassword();
      if (fAgreementNo != null) {
        fAgreementNo.then((agrno) {
          if (agrno != null && agrno.isNotEmpty) {
            if (fEmail != null) {
              fEmail.then((email) {
                if (email != null && email.isNotEmpty) {
                  //if (fPassword != null) {
                  // fPassword.then((password) {
                  // if (password != null && password.isNotEmpty) {
                  var networkAvailable = Utility.isNetworkAvailable();
                  if (networkAvailable != null) {
                    networkAvailable.then((isNetworkReady) {
                      if (isNetworkReady) {
                        _callApiGetProductList(userId: agrno, categoryId: email, subCategoryId: '');
                        setState(() {
                          AppConstants.userId = agrno;
                          AppConstants.categoryId = email;
                          //  AppConstants.password = password;
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
                  //  }
                }
              });
            }
          }
        });
      }
    }
  }

  void _callApiGetProductList({String userId, String categoryId, String subCategoryId}) {
    var productList = _apiCalling.getProductList(userId: userId, categoryId: categoryId, subCategoryId: subCategoryId);

    if (productList != null) {
      productList.then((response) {
        if (response != null && response.isNotEmpty) {
          final Map parsed = json.decode(response);
          var productListResponse = ProductListResponse.map(parsed);

          if (productListResponse.success) {
            setState(() {
              _productList = productListResponse.users.reversed.toList();
            });
          } else {
            Utility.showAlertWithMessage(context, 'No Products Available, please add some products');
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _getAppPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
      print(_version);
      print(_buildNumber);
    });
  }

  Widget createLayout() {
    return BaseWidget(
      builder: (context, sizeConfig) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.colorPrimary,
            title: Text(
              AppConstants.APP_NAME,
              style: TextStyle(
                color: AppConstants.appBarTitleColor,
                letterSpacing: 1,
                fontSize: 19.0,
              ),
            ),
            iconTheme: new IconThemeData(color: AppConstants.iconColor),
            actions: <Widget>[
              /*IconButton(
                icon: Icon(
                  Icons.brush,
                  color: AppConstants.iconColor,
                ),
                onPressed: () {
                  showThemeChooser();
                },
              ),*/
            ],
          ),
          body: SafeArea(
            child: OrientationBuilder(
              builder: (context, orientation) {
                return RefreshIndicator(
                  onRefresh: _callGetProductList,
                  child: ListView.builder(
                      itemCount: _productList == null ? 0 : _productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
                            child: ListTile(
                              onTap: () {
                                Utility.showToast('message');
//                                Navigator.of(context).push(
//                                  MaterialPageRoute(
//                                    builder: (BuildContext context) =>
//                                        MyWebView(
//                                      title: items[index],
//                                      selectedUrl:
//                                          '${AppConstants.dsViewer}${AppConstants.agrno}&email=${AppConstants.email}&check=${AppConstants.password}&guid=${_documentList[index].guid}',
//                                    ),
//                                  ),
//                                );
                              },
                              leading: Icon(Icons.add_shopping_cart),
                              title: Text(
                                _productList[index].itemName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppConstants.textTitleColor,
                                    fontSize: AppConstants.textTitleSize,
                                    fontWeight: AppConstants.textTitleWeight),
                              ),
                              subtitle: Text('Quantity ${_productList[index].itemQuantity}',
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: AppConstants.textSubTitleColor,
                                      fontSize: AppConstants.textSubTitleSize,
                                      fontWeight: AppConstants.textSubTitleWeight)),
                              trailing: Text('₹ ${_productList[index].itemPrice}'),
                            ),
                          ),
                        );
                      }),
                );
              },
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 215,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [AppConstants.colorPrimary, AppConstants.colorAccent]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: AssetImage('images/logo.png'),
                            height: 70,
                            width: 70,
                          ),
                        ),

                        Text(
                          AppConstants.APP_NAME,
                          style: TextStyle(
                            letterSpacing: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          _userEmail == null || _userEmail == '' || _userEmail.isEmpty ? '' : _userEmail,
                          style: TextStyle(
                              letterSpacing: 1.2, color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2,
                        ),
//                  Text(
//                    'Version $_version, Build No. $_buildNumber',
//                    style: TextStyle(
//                        fontSize: 12.0,
//                        letterSpacing: 1.2,
//                        color: Colors.white),
//                  ),

//                  Center(
//                    child: Text(
//                      'Build Number $_buildNumber',
//                      style: TextStyle(
//                          letterSpacing: 1.2, color: Colors.grey[700]),
//                    ),
//                  ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.home,
                    color: AppConstants.colorPrimary,
                  ),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    AppRoutes.push(context, ShopSubCategorySetupScreen());
                  },
                  leading: Icon(
                    Icons.verified_user,
                    color: AppConstants.colorPrimary,
                  ),
                  title: Text('Vendor'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    AppRoutes.push(context, OrderListScreen());
                  },
                  leading: Icon(
                    Icons.shopping_basket,
                    color: AppConstants.colorPrimary,
                  ),
                  title: Text('My Orders'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => SocialScreen()),
//                );
                  },
                  leading: Icon(
                    Icons.search,
                    color: AppConstants.colorPrimary,
                  ),
                  title: Text('Search'),
                ),
                ListTile(
                  onTap: () {
                    showLogoutAlertDialog(context);
                  },
                  leading: Icon(
                    Icons.power_settings_new,
                    color: AppConstants.colorPrimary,
                  ),
                  title: Text('Logout'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopSubCategorySetupScreen()),
              );
            },
            label: Text('Add Product'),
            icon: Icon(Icons.add_circle),
            backgroundColor: Colors.pink,
          ),
        );
      },
    );
  }

  /*return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
          body: Center(
        child: Text(sizingInformation.toString()),
      ));
    });*/

  showLogoutAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("YES"),
      onPressed: () {
        AppSharedPreference.setFirstTimeLaunch(false);
        AppSharedPreference.setShopVerified(false);
        AppSharedPreference.setUserId('');
        AppSharedPreference.setCategoryId('');
        AppSharedPreference.setJwtToken('');
        AppSharedPreference.setRefreshToken('');

        AppRoutes.setFirst(context, '/');
        //login
      },
    );

    Widget okCancel = FlatButton(
      child: Text("NO"),
      onPressed: () {
        AppRoutes.pop(context);
        AppRoutes.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Confirm'),
      content: Text('Are you sure want to Logout?'),
      actions: [okButton, okCancel],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showThemeChooser() {
    // set up the button

    Widget btnCancel = FlatButton(
      child: Text('CANCEL'),
      onPressed: () {
        AppRoutes.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      title: Text(
        'Theme',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          color: AppConstants.textColor,
        ),
      ),
      content: Container(
        // Specify some width
        width: MediaQuery.of(context).size.width * .8,
        child: OrientationBuilder(builder: (context, orientation) {
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(15),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            shrinkWrap: true,
            crossAxisCount: orientation == Orientation.portrait ? 4 : 8,
            children: <Widget>[
              _createColorItem(AppConstants.colorDocPrimary, 0, false),
              _createColorItem(AppConstants.colorOnePrimary, 1, false),
              _createColorItem(AppConstants.colorTwoPrimary, 2, false),
              _createColorItem(AppConstants.colorThreePrimary, 3, false),
              _createColorItem(AppConstants.colorFourPrimary, 4, false),
              _createColorItem(AppConstants.colorFivePrimary, 5, false),
              _createColorItem(AppConstants.colorSixPrimary, 6, false),
              _createColorItem(AppConstants.colorSevenPrimary, 7, false),
              _createColorItem(AppConstants.colorEightPrimary, 8, true),
              _createColorItem(AppConstants.colorNinePrimary, 9, false),
              _createColorItem(AppConstants.colorTenPrimary, 10, false),
              _createColorItem(AppConstants.colorElevenPrimary, 11, false),
              _createColorItem(AppConstants.colorTwelvePrimary, 12, false),
              _createColorItem(AppConstants.colorThirteenPrimary, 13, false),
              _createColorItem(AppConstants.colorFourteenPrimary, 14, false),
              _createColorItem(AppConstants.colorFifteenPrimary, 15, false),
              _createColorItem(AppConstants.colorSixteenPrimary, 16, false),
              _createColorItem(AppConstants.colorSeventeenPrimary, 17, false),
              _createColorItem(AppConstants.colorEighteenPrimary, 18, false),
              _createColorItem(AppConstants.colorNineteenPrimary, 19, false)
            ],
          );
        }),
      ),
      actions: [btnCancel],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _createColorItem(Color color, int code, bool isSelected) {
    return GestureDetector(
      onTap: () {
        AppSharedPreference.setCurrentTheme(code);

        print('Theme code : $code');
        _updateTheme(code);
        AppRoutes.pop(context);
      },
      child: Container(
        width: 30,
        height: 30,
        color: color,
        child: _currentTheme == code
            ? Icon(
                Icons.check,
                size: 35.0,
                color: Colors.white,
              )
            : Text(''),
      ),
    );
  }

  void _updateTheme(int code) {
    switch (code) {
      case 0:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorDocPrimary;
          AppConstants.colorAccent = AppConstants.colorDocAccent;
          _currentTheme = code;
        });
        break;
      case 1:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorOnePrimary;
          AppConstants.colorAccent = AppConstants.colorOneAccent;
          _currentTheme = code;
        });
        break;
      case 2:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTwoPrimary;
          AppConstants.colorAccent = AppConstants.colorTwoAccent;
          _currentTheme = code;
        });
        break;
      case 3:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorThreePrimary;
          AppConstants.colorAccent = AppConstants.colorThreeAccent;
          _currentTheme = code;
        });
        break;
      case 4:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFourPrimary;
          AppConstants.colorAccent = AppConstants.colorFourAccent;
          _currentTheme = code;
        });
        break;
      case 5:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFivePrimary;
          AppConstants.colorAccent = AppConstants.colorFiveAccent;
          _currentTheme = code;
        });
        break;
      case 6:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSixPrimary;
          AppConstants.colorAccent = AppConstants.colorSixAccent;
          _currentTheme = code;
        });
        break;
      case 7:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSevenPrimary;
          AppConstants.colorAccent = AppConstants.colorSevenAccent;
          _currentTheme = code;
        });
        break;
      case 8:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorEightPrimary;
          AppConstants.colorAccent = AppConstants.colorEightAccent;
          _currentTheme = code;
        });
        break;
      case 9:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorNinePrimary;
          AppConstants.colorAccent = AppConstants.colorNineAccent;
          _currentTheme = code;
        });
        break;
      case 10:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTenPrimary;
          AppConstants.colorAccent = AppConstants.colorTenAccent;
          _currentTheme = code;
        });
        break;
      case 11:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorElevenPrimary;
          AppConstants.colorAccent = AppConstants.colorElevenAccent;
          _currentTheme = code;
        });
        break;
      case 12:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTwelvePrimary;
          AppConstants.colorAccent = AppConstants.colorTwelveAccent;
          _currentTheme = code;
        });
        break;
      case 13:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorThirteenPrimary;
          AppConstants.colorAccent = AppConstants.colorThirteenAccent;
          _currentTheme = code;
        });
        break;
      case 14:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFourteenPrimary;
          AppConstants.colorAccent = AppConstants.colorFourteenAccent;
          _currentTheme = code;
        });
        break;
      case 15:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFifteenPrimary;
          AppConstants.colorAccent = AppConstants.colorFifteenAccent;
          _currentTheme = code;
        });
        break;
      case 16:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSixteenPrimary;
          AppConstants.colorAccent = AppConstants.colorSixteenAccent;
          _currentTheme = code;
        });
        break;
      case 17:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSeventeenPrimary;
          AppConstants.colorAccent = AppConstants.colorSeventeenAccent;
          _currentTheme = code;
        });
        break;
      case 18:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorEighteenPrimary;
          AppConstants.colorAccent = AppConstants.colorEighteenAccent;
          _currentTheme = code;
        });
        break;
      case 19:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorNineteenPrimary;
          AppConstants.colorAccent = AppConstants.colorNineteenAccent;
          _currentTheme = code;
        });
        break;
    }
  }
}
