import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/customviews/svg_widget.dart';
import 'package:app/models/pojos/category_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/screens/vendor_search_screen.dart';
import 'package:app/screens/user_search_vendor_screen.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class UserCategorySelectionScreen extends StatefulWidget {
  @override
  _UserCategorySelectionScreenState createState() =>
      _UserCategorySelectionScreenState();
}

class _UserCategorySelectionScreenState
    extends State<UserCategorySelectionScreen> {
  APICalling _apiCalling = APICalling();
  List<Category> _categoryList = [];
  String _userEmail;

  @override
  void initState() {
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
    var jwtToken = AppSharedPreference.getJwtToken();
    if (jwtToken != null) {
      jwtToken.then((jwt) {
        if (jwt != null && jwt.isNotEmpty) {
          setState(() {
            AppConstants.jwt = jwt;
          });

          var categoryList = _apiCalling.getCategoryList();
          if (categoryList != null) {
            categoryList.then((jsonResponse) {
              final Map parsed = json.decode(jsonResponse);
              var categoryResponse = CategoryResponse.map(parsed);
              if (categoryResponse.success) {
                setState(() {
                  _categoryList = categoryResponse.category;
                });
              }
            });
          }
        }
      });
    }

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
            // _callApi(userId: AppConstants.userId);
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
                  // _callApi(userId: userId);
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

  Widget _createMenu(String path, Category category, Orientation orientation) {
    bool isPortrait = orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {
        AppRoutes.push(context, VendorSearchScreen(category));
      },
      child: Card(
        elevation: 3.5,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[100], width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgWidget(
              imgPath: path,
              height: isPortrait
                  ? SizeConfig.safeBlockVertical * 7.5
                  : SizeConfig.safeBlockHorizontal * 7.5,
              width: isPortrait
                  ? SizeConfig.safeBlockHorizontal * 7.5
                  : SizeConfig.safeBlockVertical * 7.5,
              //color: AppConstants.colorPrimary,
              allowDrawingOutsideViewBox: false,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              category.categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppConstants.textColor,
                  fontSize: isPortrait
                      ? SizeConfig.defaultPMenuSize
                      : SizeConfig.defaultLMenuSize,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  /*void onMenuClick(String title) {
    switch (title) {
      case 'Grocery':
        print('Grocery');
        AppRoutes.push(context, VendorSearchScreen());
        break;
      case 'Vegetable':
        print('Vegetable');
        AppRoutes.push(context, VendorSearchScreen());
        break;
      case 'Medicine':
        print('Medicine');
        AppRoutes.push(context, VendorSearchScreen());
        break;
      case 'Stationary':
        print('Stationary');
        AppRoutes.push(context, VendorSearchScreen());
        break;
      case 'References':
        print('References');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => ClientManagerScreen()),
//        );
        break;
      case 'Add Reference':
        print('Add Reference');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => AddReferenceScreen()),
//        );
        break;
      default:
        AppRoutes.push(context, VendorSearchScreen());
        break;
    }
  }*/

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
                'User Category Selection',
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
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  OrientationBuilder(builder: (context, orientation) {
                    return GridView.builder(
                      itemCount: _categoryList.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 4),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _createMenu('svgs/grocery.svg',
                              _categoryList[index], orientation),
                        );
                      },
                    );
                    /* return GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(15),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      shrinkWrap: true,
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 4,
                      children: <Widget>[
                        _createMenu('svgs/grocery.svg', 'Grocery', orientation),
                        _createMenu(
                            'svgs/vegetable.svg', 'Vegetable', orientation),
                        _createMenu(
                            'svgs/medicine.svg', 'Medicine', orientation),
                        _createMenu('svgs/pen.svg', 'Stationary', orientation),
                      ],
                    );*/
                  }),
                ],
              ),
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
                      gradient: LinearGradient(colors: [
                        AppConstants.colorPrimary,
                        AppConstants.colorAccent
                      ]),
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
                          _userEmail == null ||
                                  _userEmail == '' ||
                                  _userEmail.isEmpty
                              ? ''
                              : _userEmail,
                          style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2,
                        ),
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
//                ListTile(
//                  onTap: () {
//                    Navigator.pop(context);
//                  },
//                  leading: Icon(
//                    Icons.search,
//                    color: AppConstants.colorPrimary,
//                  ),
//                  title: Text('Search'),
//                ),
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
        );
      },
    );
  }

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
}
