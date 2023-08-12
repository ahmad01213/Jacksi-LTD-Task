

class ApiConstants {
   static const baseUrl ="https://Limousine.urapp.site";
//  static const baseUrl = "https://18f4-196-133-34-42.ngrok-free.app";
  static const baseUrlImages = "$baseUrl/images/";

  static const getDataHomePath = "$baseUrl/product/get-home";
  static const addProductPath = "$baseUrl/product/add-product";
  static const getProductsByCategoryIdPath =
      "$baseUrl/product/get-products-by-category?";

  static const uploadImagesPath =
      "$baseUrl/image/upload/image";

  static String imageUrl(path) => "$baseUrlImages/$path";

  


}
