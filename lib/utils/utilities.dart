import 'dart:io';

import 'package:app/customviews/svg_widget.dart';
import 'package:app/screens/webview_screen.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
    return false;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  /*static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

/*
  static void openWebsite(
      {BuildContext context, String caption, String website}) {
    try {
      var networkAvailable = Utility.isNetworkAvailable();
      if (networkAvailable != null) {
        networkAvailable.then((isNetworkReady) {
          if (isNetworkReady) {
            if (website != null && website != '') {
              print('loading url: $website');
              var externalAppFlag = AppSharedPreference.isExternalAppFlag();
              if (externalAppFlag != null) {
                externalAppFlag.then((flag) {
                  if (flag != null && flag) {
                    print('Plugin not available');
                    //launch(website);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyWebView(
                                  title: caption,
                                  selectedUrl: website,
                                )));
                  }
                });
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: caption,
                              selectedUrl: website,
                            )));
              }
            } else {
              print('Website url is null');
              showAlertDialog(context, caption);
            }
          } else {
            Utility.showToast(AppConstants.MSG_INTERNET_NOT);
          }
        });
      } else {
        Utility.showToast(AppConstants.MSG_NETWORK_CHECK);
      }
    } catch (e) {
      print(e.toString());
    }
  }
*/

  static Widget setDocumentIcon(String fileType) {
    String imagePath;
    // Document Type
    switch (fileType.toLowerCase()) {
      case AppConstants.DOC_PDF:
        imagePath = 'svgs/pdf.svg';
        break;
      case AppConstants.DOC_XLSX:
        imagePath = 'svgs/xlsx.svg';
        break;
      case AppConstants.DOC_MSG:
        imagePath = 'svgs/msg.svg';
        break;
      case AppConstants.DOC_DOCX:
        imagePath = 'svgs/doc.svg';
        break;
      case AppConstants.DOC_EML:
        imagePath = 'svgs/eml.svg';
        break;
      case AppConstants.DOC_PPT:
        imagePath = 'svgs/ppt.svg';
        break;
      case AppConstants.DOC_TXT:
        imagePath = 'svgs/txt.svg';
        break;
      case AppConstants.DOC_JPG:
        imagePath = 'svgs/jpg.svg';
        break;
      case AppConstants.DOC_PNG:
        imagePath = 'svgs/png.svg';
        break;
      case AppConstants.DOC_ZIP:
        imagePath = 'svgs/zip.svg';
        break;
      case AppConstants.DOC_MCO:
        imagePath = 'svgs/mco.svg';
        break;
      case AppConstants.DOC_RTF:
        imagePath = 'svgs/rtf.svg';
        break;
      default:
        imagePath = 'svgs/document.svg';
        break;
    }

    return SvgWidget(
      imgPath: imagePath,
      height: 45.0,
      width: 45.0,
      color: AppConstants.colorPrimary,
      allowDrawingOutsideViewBox: false,
    );
  }

  static void showAlertDialog(BuildContext context, String caption) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error Occurred"),
      content: Text("Sorry can not load $caption page."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showAlertWithMessage(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Message'),
      content: Text(message),
      actions: [
        okButton,
      ],
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
