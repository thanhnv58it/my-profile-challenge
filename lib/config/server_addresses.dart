class ServerAddresses {
  static const serverAddress = 'dummyjson.com';

  static const loginPath = 'auth/login';
  static const searchPath = 'products/search';
  static const categoriesPath = 'products/categories';
  static const productsPath = 'products';
  static const productsByCategoryPath = 'products/category';

  static String getProductsByCategoryPath(String category) {
    return '$productsByCategoryPath/$category';
  }
}
