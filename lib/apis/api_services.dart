import 'dart:convert';

import 'package:app/models/address_model.dart';

//import 'package:app/models/agreement_details.dart';
import 'package:app/models/app_services.dart';
import 'package:app/utils/app_constants.dart';
import 'package:http/http.dart' as http;

import 'service_constants.dart';

class APICalling {
  static final APICalling _singleton = APICalling._internal();

  factory APICalling() {
    return _singleton;
  }

  APICalling._internal();

  static const String _BASE_URL = 'http://linkshoppy.com/codeingnter/index.php/Api/';

  Future<String> getLogin({String email, String password}) async {
    var url = _BASE_URL + ServiceConstants.Json_Login;
    var body = {'email': email, 'password': password};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> setUserRegistration({String name, String email, String password, String mobile, String roleId}) async {
    var url = _BASE_URL + ServiceConstants.Json_UserRegistration;
    var body = {'name': name, 'email': email, 'password': password, 'mobile': mobile, 'role_id': roleId};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> getCategoryList() async {
    var url = _BASE_URL + ServiceConstants.Json_CategoryList;

    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};

    print("Calling Api: $url");
//    print("params: $body");
//    var response = await http.post(url, body: body);
    var response = await http.get(url, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> setShopSetup(
      {String userId,
      String categoryId,
      String contactName,
      String contactMobile,
      String shopName,
      String shopAddress,
      String base64Image}) async {
    var url = _BASE_URL + ServiceConstants.Json_ShopSetup;
    var body = {
      'user_id': userId,
      'category_id': categoryId,
      'contact_name': contactName,
      'contact_mobile': contactMobile,
      'shop_name': shopName,
      'shop_address': shopAddress,
      'image': base64Image,
    };

    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> setAddSubCategory({String userId, String categoryId, String subCategoryName}) async {
    var url = _BASE_URL + ServiceConstants.Json_AddSubCategory;
    var body = {'user_id': userId, 'category_id': categoryId, 'sub_category_name': subCategoryName};

    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> setAddProduct(
      {String userId,
      String categoryId,
      String subCategoryId,
      String itemName,
      String itemPrice,
      String itemQuantity,
      String other}) async {
    var url = _BASE_URL + ServiceConstants.Json_AddProduct;
    var body = {
      'user_id': userId,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'item_name': itemName,
      'item_price': itemPrice,
      'item_quantity': itemQuantity,
      'other': other,
    };

    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};

    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> getProductList({String userId, String categoryId, String subCategoryId}) async {
    var url = _BASE_URL + ServiceConstants.Json_ProductList;
    var body = {'user_id': userId, 'category_id': categoryId, 'sub_category_id': subCategoryId};
    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> getSubCategoryList({String userId, String categoryId}) async {
    var url = _BASE_URL + ServiceConstants.Json_SubCategoryList;
    var body = {'user_id': userId, 'category_id': categoryId};
    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> getOrders({String userId, String categoryId}) async {
    var url = _BASE_URL + ServiceConstants.Json_Orders;
    var body = {'user_id': userId};
    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> getOrderDetails({String userId, String orderId, String categoryId}) async {
    var url = _BASE_URL + ServiceConstants.Json_OrderDetails;
    var body = {'user_id': userId, 'order_id': orderId};
    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> getSearchShop({String categoryId, String shopName, String shopAddress}) async {
    var url = _BASE_URL + ServiceConstants.Json_SearchShop;
    var body = {'category_id': categoryId, 'shop_name': shopName, 'shop_address': shopAddress};
    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String> getOrderProductList({String userId, String categoryId, String subCategoryId}) async {
    var url = _BASE_URL + ServiceConstants.Json_ProductList;
    var body = {'user_id': userId, 'category_id': categoryId, 'sub_category_id': subCategoryId};
    var headers = {'x-auth': 'Bearer ${AppConstants.jwt}', "Accept": "application/json"};
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }

  //Json_orderGenerate
  Future<String> setOrderGenerate({String userId, String shopId, String items}) async {
    var url = _BASE_URL + ServiceConstants.Json_orderGenerate;
    var body = {'user_id': userId, 'shop_id': shopId, 'items': items};
    var headers = {
      'x-auth': 'Bearer ${AppConstants.jwt}',
      "Content-Type": "application/x-www-form-urlencoded",
      "Cache-Control": "no-cache",
    };
    print("Calling Api: $url");
    print("params: $body");
    var response = await http.post(url, body: body, headers: headers);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null) {
      return response.body;
    }
    return null;
  }
}
