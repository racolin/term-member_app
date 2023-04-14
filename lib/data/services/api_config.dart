class Environment {
  final String base;
  final String url;
  // final String baseImage;

  Environment._({
    required this.base,
    required this.url,
    // required this.baseImage,
  });
  factory Environment.dev() {
    return Environment._(
      base: 'api/',
      url: 'http://127.0.0.1:8080/',
      // baseImage: 'file/render/',
    );
  }
}

// Config environment
class AppConfig{
  factory AppConfig({Environment? env}){

    if(env !=null){
      appConfig.env = env;
    }
    return appConfig;
  }
  AppConfig._private();
  static final AppConfig appConfig = AppConfig._private();
  Environment env = Environment.dev();
}

class ApiRouter {

  // Auth
  static const String authLogin = '/member/auth/login';
  static const String authRegister = '/member/auth/register';
  static const String authSmsVerify = '/member/auth/sms-verify';
  static const String authRefresh = '/member/auth/refresh';

  // Appbar
  static const String appAppbar = '/member/app/appbar';

  // Member card
  static const String memberRankCard = '/member/member-rank/card';

  // Voucher
  static const String voucherAvailable = '/member/voucher/available';
  static const String voucherUsed = '/member/voucher/used';

  // Promotion
  static const String promotionAll = '/member/promotion/all';
  static const String promotionCategoryAll = '/member/promotion-category/all';

  // Member data
  static const String memberDataPointHistory = '/member/member-data/point-history';

  // Product
  static const String productAll = '/member/product/all';
  static String productFavoriteUpdate(String id) => '/member/product/$id/favorite';
  static const String productFavoriteAll = '/member/product/favorite/all';
  static const String productCategoryAll = '/member/product-category/all';
  static const String productOptionAll = '/member/product-option/all';

  // Cart
  static String cartStatusGet(String id) => '/member/cart-status/$id';
  static String cartGet(String id) => '/member/cart/$id';
  static const String cartStatusAll = '/member/cart-status/all';
  static const String cartReview = '/member/cart/review';
  static const String cartCheckVoucher = '/member/cart/check-voucher';
  static const String cartCreate = '/member/cart/create';

  // Cart template
  static const String cartTemplateAll = '/member/cart-template/all';
  static const String cartTemplate = 'member/cart-template';
  static String cartTemplatePut(String id) => '/member/cart-template/$id';
  static const String cartTemplateArrange = '/member/cart-template/arrange';
  static String cartTemplateDelete(String id) => '/member/cart-template/$id';

  // News
  static const String news = 'Member/news';

  // Store
  static const String storeShort = '/member/store/short';
  static String storeGet(String id) => '/member/store/$id';
  static String storeFavoritePatch(String id) => '/member/store/$id/favorite';

  // Notify
  static const String notificationAll = '/member/notification/all';
  static String notificationCheckPatch(String id) => '/member/notification/$id/check';

  // Setting
  static const String settingProfile = '/member/setting/profile';
  static const String settingAddress = '/member/setting/address';
  static String settingAddressDelete(String id) => '/member/setting/address/$id';
  static const String settingNotification = '/member/setting/notification';

}
