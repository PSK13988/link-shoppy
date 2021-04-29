import 'package:app/models/pojos/category_response.dart';
import 'package:app/screens/user_search_vendor_screen.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';

class VendorSearchScreen extends StatefulWidget {
  final Category category;
  VendorSearchScreen(this.category);
  @override
  _VendorSearchScreenState createState() => _VendorSearchScreenState(category);
}

class _VendorSearchScreenState extends State<VendorSearchScreen> {
  Category category;
  _VendorSearchScreenState(this.category);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.colorPrimary,
            title: Text(
              'Vendor Search',
              style: TextStyle(
                color: AppConstants.appBarTitleColor,
                letterSpacing: 1.2,
                fontSize: 19.0,
              ),
            ),
            iconTheme: new IconThemeData(color: AppConstants.iconColor),
            bottom: TabBar(tabs: [
              Tab(
                text: "Search By Location",
              ),
              Tab(
                text: "Search by Vendor",
              ),
            ]),
            actions: <Widget>[],
          ),
          body: TabBarView(children: [
            UserSearchVendorScreen(category, AppConstants.SEARCH_BY_LOCATION),
            UserSearchVendorScreen(category, AppConstants.SEARCH_BY_VENDOR),
          ]),
        ));
  }

  showLogoutAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("YES"),
      onPressed: () {
        AppSharedPreference.setFirstTimeLaunch(false);
        AppRoutes.setFirst(context, '/');
        //login
      },
    );

    Widget okCancel = FlatButton(
      child: Text("NO"),
      onPressed: () {
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
