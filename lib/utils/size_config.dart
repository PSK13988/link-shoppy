import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  // app font sizes
  static double defaultTextSize;
  static double defaultPSubTextSize;
  static double defaultLSubTextSize;
  static double defaultLargeHeadingSize;
  static double defaultMediumHeadingSize;
  static double defaultPMenuSize;
  static double defaultLMenuSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    defaultTextSize = safeBlockHorizontal * 3.8;
    defaultPSubTextSize = safeBlockHorizontal * 4;
    defaultLSubTextSize = safeBlockVertical * 4;
    defaultLargeHeadingSize = safeBlockHorizontal * 5.5;
    defaultMediumHeadingSize = safeBlockHorizontal * 5;
    defaultPMenuSize = safeBlockHorizontal * 4.5;
    defaultLMenuSize = safeBlockVertical * 4.5;
  }
}
