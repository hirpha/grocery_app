String imageBaseUrl = "https://stagingchipchip.fra1.digitaloceanspaces.com/";
String baseUrl = "https://stagingapi.chipchip.social/";

class EndPoints {
  static String login() {
    return "${baseUrl}v1/users/login";
  }

  static String profile() {
    return "${baseUrl}v1/users";
  }

  static String products() {
    return "${baseUrl}v1/products";
  }

  static String productDetail(String id) {
    return "${baseUrl}v1/products/$id";
  }

  static String categories() {
    return "${baseUrl}v1/categories";
  }
}
