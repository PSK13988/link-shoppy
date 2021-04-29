import 'package:flutter/material.dart';

class AppConstants {
  static final AppConstants _singleton = AppConstants._internal();

  factory AppConstants() {
    return _singleton;
  }

  AppConstants._internal();

  static const String APP_NAME = 'LinkShoppy';

  static String userId = '';
  static String categoryId = '';
  //static String password = '';
  static String jwt = '';
  static String refresh = '';
  // App colors

  static const String VENDOR_ROLE = '2';
  static const String USER_ROLE = '3';

  static const String SEARCH_BY_LOCATION = 'location';
  static const String SEARCH_BY_VENDOR = 'vendor';

  static Color colorPrimary = Color(0xff1e3554);
  static Color colorAccent = Color(0xff2196f3);

  static Color iconColor = Colors.white;
  static Color appBarTitleColor = Colors.white;

  static const Color textColor = Colors.black54;
  static const double textSize = 16.0;

  static Color textTitleColor = Colors.grey[800];
  static const double textTitleSize = 18.5;
  static FontWeight textTitleWeight = FontWeight.w500;

  static Color textSubTitleColor = Colors.grey[600];
  static const double textSubTitleSize = 16;
  static FontWeight textSubTitleWeight = FontWeight.w400;

  static const double textMediumSize = 17.0;

  static const Color colorDocPrimary = Color(0xff1e3554);
  static const Color colorDocAccent = Color(0xffec1b67);

  static const Color colorOnePrimary = Color(0XFF880E4F);
  static const Color colorOneAccent = Color(0XFFBC5089);

  static const Color colorTwoPrimary = Color(0XFFD81B60);
  static const Color colorTwoAccent = Color(0XFFE4719B);

  static const Color colorThreePrimary = Color(0XFF4A148C);
  static const Color colorThreeAccent = Color(0XFF9465CD);

  static const Color colorFourPrimary = Color(0XFF9C27B0);
  static const Color colorFourAccent = Color(0XFFD076DF);

  static const Color colorFivePrimary = Color(0XFF311B92);
  static const Color colorFiveAccent = Color(0XFF8270CD);

  static const Color colorSixPrimary = Color(0XFF673AB7);
  static const Color colorSixAccent = Color(0XFF9F82D1);

  static const Color colorSevenPrimary = Color(0xff3f51b5);
  static const Color colorSevenAccent = Color(0XFF6C7ACD);

  static const Color colorEightPrimary = Color(0xff0d47a1);
  static const Color colorEightAccent = Color(0XFF466AA1);

  static const Color colorNinePrimary = Color(0xff2196f3);
  static const Color colorNineAccent = Color(0xff6faee1);

  static const Color colorTenPrimary = Color(0xff01579b);
  static const Color colorTenAccent = Color(0xff579dd5);

  static const Color colorElevenPrimary = Color(0XFF03A9F4);
  static const Color colorElevenAccent = Color(0XFF86C5E3);

  static const Color colorTwelvePrimary = Color(0XFF006064);
  static const Color colorTwelveAccent = Color(0XFF4EB9BD);

  static const Color colorThirteenPrimary = Color(0XFF004D40);
  static const Color colorThirteenAccent = Color(0XFF4ABCA9);

  static const Color colorFourteenPrimary = Color(0XFF1B5E20);
  static const Color colorFourteenAccent = Color(0XFF4C9F52);

  static const Color colorFifteenPrimary = Color(0XFF33691E);
  static const Color colorFifteenAccent = Color(0XFF80D161);

  static const Color colorSixteenPrimary = Color(0XFF827717);
  static const Color colorSixteenAccent = Color(0XFFBFB349);

  static const Color colorSeventeenPrimary = Color(0XFFF57F17);
  static const Color colorSeventeenAccent = Color(0XFFFAA860);

  static const Color colorEighteenPrimary = Color(0XFFFF6F00);
  static const Color colorEighteenAccent = Color(0XFFF49247);

  static const Color colorNineteenPrimary = Color(0XFFE65100);
  static const Color colorNineteenAccent = Color(0XFFDD7841);

  // Document Type
  static const String DOC_PDF = "pdf";
  static const String DOC_XLSX = "xlsx";
  static const String DOC_MSG = "msg";
  static const String DOC_DOCX = "docx";
  static const String DOC_EML = "eml";
  static const String DOC_PPT = "ppt";
  static const String DOC_TXT = "txt";
  static const String DOC_JPG = "jpg";
  static const String DOC_PNG = "png";
  static const String DOC_ZIP = "zip";
  static const String DOC_MCO = "mco";
  static const String DOC_RTF = "rtf";

  static String dsViewer = "https://www.mydocusoft.co.uk/DSViewer.aspx?accid=";

  // Constant URLs
  static const String URL_CONTACT_US = 'https://www.docusoft.net/contact-us/';
  static const String URL_DOCUBOX_URL =
      'https://www.sharedocuments.co.uk/login.aspx?Code=';
  static const String URL_WEBSITE = 'https://gloverstanbury.co.uk/';
  static const String URL_SHARE_FUND_PRICES = 'https://markets.ft.com/data';
  static const String URL_BLOG = 'https://gloverstanbury.co.uk/blog/';
  static const String URL_CLIENT_PORTAL = 'https://www.docusoft.net/support/';
  static const String URL_FACEBOOK_PAGE = 'https://www.facebook.com/Docusoft';
  static const String URL_TWITTER_PAGE = 'https://twitter.com/docusoft';
  static const String URL_LINKEDIN_PAGE =
      'https://www.linkedin.com/company/docusoft/';
  static const String URL_PINTEREST_PAGE =
      'https://in.pinterest.com/docusoft593/';
  static const String URL_YOUTUBE_HOME_PAGE =
      'https://www.youtube.com/channel/UCtm6fus7TAznCosdiRB-hdg';

  static const String URL_GLOVER_STANBURY =
      'https://gloverstanbury.co.uk/testimonials/';
  static const String URL_SATAGO = 'https://www.satago.com/';
  static const String URL_WHY_XERO =
      'https://www.xero.com/uk/resources/small-business-guides/cloud-accounting/mobile-accounting-app/';
  static const String URL_XERO_LOGIN =
      'https://www.xero.com/uk/features-and-tools/mobile/xero-touch/';
  static const String URL_MEET_THE_TEAM =
      'https://gloverstanbury.co.uk/meet-the-team/';
  static const String URL_CURRENCY_CONVERTER = 'https://www.xe.com/';
  static const String URL_PORTAL =
      'https://www.docusoftcloud.net/login.aspx?Code=1091';
  static const String URL_FINANCIAL_NEWS = 'https://www.ft.com/';
  static const String URL_VIDEOS =
      'https://www.youtube.com/user/knsalter/videos';
  static const String URL_ACCOUNTING_SOFTWARE =
      'https://gloverstanbury.co.uk/xero/';
  static const String URL_NEWSLETTER =
      'https://gloverstanbury.co.uk/latest-newsletter/';
  static const String URL_BUSINESS_TOOLS =
      'https://gloverstanbury.co.uk/businesstools/gloverstanbury.html#!/';
  static const String URL_FFAP = 'http://ffap.mydocusoft.co.uk/Login.aspx';
  static const String URL_RECEIPT_BANK = 'https://www.receipt-bank.com/';
  static const String URL_DOCUSOFT = 'https://www.mydocusoft.co.uk/';
  static const String URL_AUTO_ENTRY = 'https://www.autoentry.com/';
  static const String URL_QTOOLS = 'https://www.qtoolsonline.co.uk/';
  static const String URL_XERO = 'https://www.xero.com/uk/';
  static const String URL_SCANNER = 'url_scanner';
  static const String URL_CORPORATION_TAX =
      'http://www.calc.qtoolsonline.co.uk/DSCalculator.aspx?calc=cms-incorporation';
  static const String URL_FUEL_BENEFIT =
      'http://www.calc.qtoolsonline.co.uk/DSCalculator.aspx?calc=fuel-benefit-checker';
  //   final String URL_LOAN_CALCULATOR = 'https://www.calc.qtoolsonline.co.uk/DSCalculator.aspx?calc=loan-calculator';
  static const String URL_CALCULATOR = 'http://www.calc.qtoolsonline.co.uk/';
  static const String URL_GSAPPICON_FOLDER =
      'https://www.mydocusoft.co.uk/gsappicon/';

  // server calculator urls
  static const String URL_DEBTOR_DAYS =
      'https://the2020software.com/practiceapp/debtor.html';
  static const String URL_LOAN_CALCULATOR =
      'https://the2020software.com/practiceapp/loan.html';
  static const String URL_MARKUP_GROSS_PROFIT =
      'https://the2020software.com/practiceapp/markup.html';
  static const String URL_PAYROLL =
      'https://the2020software.com/practiceapp/payslip.html';
  static const String URL_SAVINGS =
      'https://the2020software.com/practiceapp/saving.html';
  static const String URL_SIMPLE_VAT =
      'https://the2020software.com/practiceapp/vat.html';

  static const String URL_TAX_INFO =
      'https://the2020software.com/practiceapp/tax-table.html';
  static const String URL_HOW_WE_HELP =
      'https://the2020software.com/practiceapp/help.html';
  static const String URL_IMPORTANT_DATES =
      'https://the2020software.com/practiceapp/financial-dates.html';

  // App constant message
  static const MSG_INTERNET_NOT = 'Internet not available please try again!';
  static const MSG_ERROR = 'Error occured';
  static const MSG_UNKNOWN_ERROR = 'Unknown error occured';
  static const MSG_NETWORK_CHECK =
      'Please check your device network connection';
  static const MSG_THIS_MENU_IS_DISABLED = 'This menu is disabled';
  static const MSG_DATA_NOT_AVAILABLE = 'Data not available';
  static const MSG_UNDER_DEVELOPMENT = 'This feature is under development';
  static const MSG_COMPANY_DETAILS_NOT_AVAILABLE =
      'Company details not available';
  static const MSG_SERVICES_NOT_AVAILABLE = 'Services not available';
  static const MSG_SERVICES_NOT_AVAILABLE_RETRY =
      'Services not available, Tap her to retry';
}
