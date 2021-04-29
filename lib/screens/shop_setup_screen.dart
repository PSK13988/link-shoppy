import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:app/apis/api_services.dart';
import 'package:app/models/pojos/category_response.dart';
import 'package:app/models/pojos/login_response.dart';
import 'package:app/models/pojos/status_response.dart';
import 'package:app/screens/abase_widget.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/utilities.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ShopSetupScreen extends StatefulWidget {
  @override
  _ShopSetupScreenState createState() => _ShopSetupScreenState();
}

class _ShopSetupScreenState extends State<ShopSetupScreen> {
  APICalling _apiCalling = APICalling();
  final FocusNode _shopName = FocusNode();
  final FocusNode _shopImage = FocusNode();
  final FocusNode _shopAddress = FocusNode();
  final FocusNode _contactPerson = FocusNode();
  final FocusNode _contactPersonMobile = FocusNode();
  final _shopNameController = TextEditingController();
  final _shopImageController = TextEditingController();
  final _shopAddressController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final __contactPersonMobileController = TextEditingController();
  List<dynamic> companyList;
  List<Category> _categoryList = [];
  Category _selectedCategory;
  String _userId;
  File file;

  @override
  void initState() {
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

    var fCurrentTheme = AppSharedPreference.getCurrentTheme();
    fCurrentTheme.then((value) {
      if (value != null) {
        print('Code : $value');
        _updateTheme(value);
      }
    });

    var fuserId = AppSharedPreference.getUserId();
    if (fuserId != null) {
      fuserId.then((userId) {
        print('UserId: $userId');
        if (userId != null && userId.isNotEmpty) {
          _userId = userId;
        }
      });
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        'Please select your shop category',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categoryList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _categoryList[index];
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Card(
                                  color: Colors.blue,
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                      _categoryList[index].categoryName,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    )),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _selectedCategory != null
                        ? Text(
                            'Selected Category : ${_selectedCategory.categoryName}',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Selected Category : ',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Shop Name',
                        labelText: 'Shop Name',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _shopName,
                      controller: _shopNameController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () async {
                        File pickedFile = await FilePicker.getFile();

                        print('Picked File: ${pickedFile.readAsBytes()}');
                        setState(() {
                          file = pickedFile;
                          _shopImageController.text = basename(file.path);
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Shop Image',
                        labelText: 'Shop Image',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      focusNode: _shopImage,
                      controller: _shopImageController,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    file != null
                        ? SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.file(
                              File(file.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Shop Address',
                        labelText: 'Shop Address',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _shopAddress,
                      controller: _shopAddressController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contact person',
                        labelText: 'Contact person',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _contactPerson,
                      controller: _contactPersonController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contact person mobile',
                        labelText: 'Contact person mobile',
                      ),
                      style: TextStyle(fontSize: AppConstants.textMediumSize),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      focusNode: _contactPersonMobile,
                      controller: __contactPersonMobileController,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonTheme(
                      height: 50.0,
                      child: RaisedButton(
                        color: AppConstants.colorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: AppConstants.colorPrimary)),
                        onPressed: () {
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
        );
      },
    );
  }

  void validateForm() {
    if (_userId == null) {
      Utility.showToast('User data not available');
      return;
    }

    if (_selectedCategory == null) {
      Utility.showToast('Please select category');
      return;
    }

    if (_shopNameController.text.trim().isEmpty) {
      Utility.showToast('Please enter shop name');
      _shopName.requestFocus();
      return;
    }

    if (_shopAddressController.text.trim().isEmpty) {
      Utility.showToast('Please enter shop address');
      _shopAddress.requestFocus();
      return;
    }

    if (_contactPersonController.text.trim().isEmpty) {
      Utility.showToast('Please contact person name');
      _contactPerson.requestFocus();
      return;
    }

    if (__contactPersonMobileController.text.trim().isEmpty) {
      Utility.showToast('Please enter contact person mobile');
      _contactPersonMobile.requestFocus();
      return;
    }

    var networkAvailable = Utility.isNetworkAvailable();
    if (networkAvailable != null) {
      networkAvailable.then((isNetworkReady) {
        if (isNetworkReady) {
          if (file == null) return;
          String base64Image = base64Encode(file.readAsBytesSync());
          //String fileName = file.path.split("/").last;

          var setShopSetup = _apiCalling.setShopSetup(
              userId: _userId,
              categoryId: _selectedCategory.id,
              contactName: _contactPersonController.text.toString().trim(),
              contactMobile:
                  __contactPersonMobileController.text.toString().trim(),
              shopName: _shopNameController.text.toString().trim(),
              shopAddress: _shopAddressController.text.toString().trim(),
              base64Image: base64Image);

          if (setShopSetup != null) {
            setShopSetup.then((jsonResponse) {
              if (jsonResponse != null && jsonResponse.isNotEmpty) {
                final Map parsed = json.decode(jsonResponse);
                var statusResponse = StatusResponse.map(parsed);

                if (statusResponse.success) {
                  navigateTo('sub_category');
                } else {
                  if (statusResponse.message != null &&
                      statusResponse.message.isNotEmpty &&
                      statusResponse.message == 'Shop already exists') {
                    navigateTo('home');
                  } else {
                    Utility.showToast(statusResponse.message);
                  }
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

  void navigateTo(String navigateTo) {
    Utility.showToast('Information saved successfully');
    AppSharedPreference.setCategoryId(_selectedCategory.id);
    print('Category Id : ${_selectedCategory.id}');
    AppSharedPreference.setShopVerified(true);
    switch (navigateTo) {
      case 'home':
        AppRoutes.setFirst(this.context, '/home');
        break;
      case 'sub_category':
        AppRoutes.setFirst(this.context, '/shopSubCategorySetup');
        break;
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void _updateTheme(int code) {
    switch (code) {
      case 0:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorDocPrimary;
          AppConstants.colorAccent = AppConstants.colorDocAccent;
        });
        break;
      case 1:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorOnePrimary;
          AppConstants.colorAccent = AppConstants.colorOneAccent;
        });
        break;
      case 2:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTwoPrimary;
          AppConstants.colorAccent = AppConstants.colorTwoAccent;
        });
        break;
      case 3:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorThreePrimary;
          AppConstants.colorAccent = AppConstants.colorThreeAccent;
        });
        break;
      case 4:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFourPrimary;
          AppConstants.colorAccent = AppConstants.colorFourAccent;
        });
        break;
      case 5:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFivePrimary;
          AppConstants.colorAccent = AppConstants.colorFiveAccent;
        });
        break;
      case 6:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSixPrimary;
          AppConstants.colorAccent = AppConstants.colorSixAccent;
        });
        break;
      case 7:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSevenPrimary;
          AppConstants.colorAccent = AppConstants.colorSevenAccent;
        });
        break;
      case 8:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorEightPrimary;
          AppConstants.colorAccent = AppConstants.colorEightAccent;
        });
        break;
      case 9:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorNinePrimary;
          AppConstants.colorAccent = AppConstants.colorNineAccent;
        });
        break;
      case 10:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTenPrimary;
          AppConstants.colorAccent = AppConstants.colorTenAccent;
        });
        break;
      case 11:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorElevenPrimary;
          AppConstants.colorAccent = AppConstants.colorElevenAccent;
        });
        break;
      case 12:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorTwelvePrimary;
          AppConstants.colorAccent = AppConstants.colorTwelveAccent;
        });
        break;
      case 13:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorThirteenPrimary;
          AppConstants.colorAccent = AppConstants.colorThirteenAccent;
        });
        break;
      case 14:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFourteenPrimary;
          AppConstants.colorAccent = AppConstants.colorFourteenAccent;
        });
        break;
      case 15:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorFifteenPrimary;
          AppConstants.colorAccent = AppConstants.colorFifteenAccent;
        });
        break;
      case 16:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSixteenPrimary;
          AppConstants.colorAccent = AppConstants.colorSixteenAccent;
        });
        break;
      case 17:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorSeventeenPrimary;
          AppConstants.colorAccent = AppConstants.colorSeventeenAccent;
        });
        break;
      case 18:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorEighteenPrimary;
          AppConstants.colorAccent = AppConstants.colorEighteenAccent;
        });
        break;
      case 19:
        setState(() {
          AppConstants.colorPrimary = AppConstants.colorNineteenPrimary;
          AppConstants.colorAccent = AppConstants.colorNineteenAccent;
        });
        break;
    }
  }
}
