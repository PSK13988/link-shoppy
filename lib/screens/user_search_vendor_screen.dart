import 'dart:convert';

import 'package:app/apis/api_services.dart';
import 'package:app/customviews/svg_widget.dart';
import 'package:app/models/pojos/category_response.dart';
import 'package:app/models/pojos/shop_list_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/screens/shop_product_list.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/utils/utilities.dart';
import 'package:flutter/material.dart';

class UserSearchVendorScreen extends StatefulWidget {
  final Category category;
  final String searchBy;

  UserSearchVendorScreen(this.category, this.searchBy);
  @override
  _UserSearchVendorScreenState createState() =>
      _UserSearchVendorScreenState(category, searchBy);
}

class _UserSearchVendorScreenState extends State<UserSearchVendorScreen> {
  Category category;
  String searchBy;
  _UserSearchVendorScreenState(this.category, this.searchBy);
  APICalling _apiCalling = APICalling();
  FocusNode _searchText = FocusNode();
  TextEditingController _searchTextController = TextEditingController();
  List<Shops> _shopsList = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> _callGetSearchShop({String searchText}) async {
    if (category != null && category.id != null && category.id.isNotEmpty) {
      print('Calling api from static data structure');
      var networkAvailable = Utility.isNetworkAvailable();
      if (networkAvailable != null) {
        networkAvailable.then((isNetworkReady) {
          if (isNetworkReady) {
            if (searchBy == AppConstants.SEARCH_BY_LOCATION) {
              _callApi(
                  categoryId: category.id,
                  shopName: '',
                  shopAddress: searchText);
            } else {
              _callApi(
                  categoryId: category.id,
                  shopName: searchText,
                  shopAddress: '');
            }
          } else {
            Utility.showToast(AppConstants.MSG_INTERNET_NOT);
          }
        });
      } else {
        Utility.showToast(AppConstants.MSG_NETWORK_CHECK);
      }
    } else {
      // fetching data from app prefs
      Utility.showToast('Category not available');
    }
  }

  void _callApi({String categoryId, String shopName, String shopAddress}) {
    var searchShop = _apiCalling.getSearchShop(
        categoryId: categoryId, shopName: shopName, shopAddress: shopAddress);
    if (searchShop != null) {
      searchShop.then((response) {
        if (response != null && response.isNotEmpty) {
          final Map parsed = json.decode(response);
          var shopListResponse = ShopListResponse.fromJson(parsed);
          if (shopListResponse.success) {
            if (shopListResponse.shops != null &&
                shopListResponse.shops.isNotEmpty) {
              setState(() {
                _shopsList = shopListResponse.shops;
              });
            } else {
              Utility.showToast(AppConstants.MSG_DATA_NOT_AVAILABLE);
            }
          }
        }
      });
    }
  }

  Widget _createMenu(String path, Shops shop, Orientation orientation) {
    bool isPortrait = orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {
        AppSharedPreference.setCategoryId(shop.categoryId);
        AppRoutes.push(context, ShopProductList(shop));
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
              shop.shopName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppConstants.textColor,
                  fontSize: isPortrait
                      ? SizeConfig.defaultPMenuSize
                      : SizeConfig.defaultLMenuSize,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              shop.shopAddress,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppConstants.textColor,
                  fontSize: isPortrait
                      ? SizeConfig.defaultPSubTextSize
                      : SizeConfig.defaultLSubTextSize,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${shop.contactName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppConstants.textColor,
                  fontSize: isPortrait
                      ? SizeConfig.defaultPSubTextSize
                      : SizeConfig.defaultLSubTextSize,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              '${shop.contactMobile}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppConstants.textColor,
                  fontSize: isPortrait
                      ? SizeConfig.defaultPSubTextSize
                      : SizeConfig.defaultLSubTextSize,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  void onMenuClick(String title) {
    switch (title) {
      case 'Dashboard':
        print('Dashboard');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => DashboardScreen()),
//        );
        break;
      case 'Search':
        print('Search');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => ReferenceSearchScreen(null)),
//        );
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (BuildContext context) => MyWebView(
//              title: 'Testing',
//              selectedUrl: 'https://flutter.dev',
//            ),
//          ),
//        );

        break;
      case 'Acquire':
        print('Acquire');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => AcquireScreen()),
//        );
        break;
      case 'Upload':
        print('Upload');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => UploadScreen()),
//        );
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
        print('Not matched title $title');
        break;
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
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: _callGetSearchShop,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: searchBy ==
                                          AppConstants.SEARCH_BY_LOCATION
                                      ? 'Location here..'
                                      : 'Vendor here',
                                  hintText: searchBy ==
                                          AppConstants.SEARCH_BY_LOCATION
                                      ? 'Location here..'
                                      : 'Vendor here',
                                ),
                                style: TextStyle(
                                    fontSize: AppConstants.textMediumSize),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                focusNode: _searchText,
                                controller: _searchTextController),
                          ),
                          Expanded(
                            flex: 2,
                            child: FlatButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _callGetSearchShop(
                                    searchText:
                                        _searchTextController.text.trim());
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'Search',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    OrientationBuilder(builder: (context, orientation) {
                      return GridView.builder(
                        itemCount: _shopsList == null ? 0 : _shopsList.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 4),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _createMenu('svgs/grocery.svg',
                                _shopsList[index], orientation),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
