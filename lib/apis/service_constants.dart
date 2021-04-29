class ServiceConstants {
  static final ServiceConstants _singleton = ServiceConstants._internal();

  factory ServiceConstants() {
    return _singleton;
  }

  ServiceConstants._internal();

  static const String Json_Login = 'login';
  static const String Json_UserRegistration = 'userRegistration';
  static const String Json_CategoryList = 'categoryList';
  static const String Json_ShopSetup = 'shopSetup';
  static const String Json_AddSubCategory = 'addSubCategory';
  static const String Json_AddProduct = 'addProduct';
  static const String Json_ProductList = 'productList';
  static const String Json_SubCategoryList = 'subCategoryList';
  static const String Json_Orders = 'orders';
  static const String Json_OrderDetails = 'orderDetails';
  static const String Json_SearchShop = 'searchShop';
  static const String Json_orderProductList = 'orderProductList';
  static const String Json_orderGenerate = 'orderGenerate';
}
