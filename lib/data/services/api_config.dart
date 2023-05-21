class Environment {
  final String _base;
  final String _url;

  Environment._({
    required String base,
    required String url,
    // required String baseImage,
  })  : _base = base,
        _url = url
  // ,_baseImage = baseImage
  ;

  String get api => _url + _base;

  static Environment? _devInstance;

  factory Environment.env() {
    return _dev;
  }

  static Environment get _dev {
    _devInstance ??= Environment._(
      base: 'api/v1/',
      url: 'http://127.0.0.1/',
      // baseImage: 'file/',
    );
    return _devInstance!;
  }
}

// Config environment
class AppConfig {
  factory AppConfig({Environment? env}) {
    if (env != null) {
      appConfig.env = env;
    }
    return appConfig;
  }

  AppConfig._private();

  static final AppConfig appConfig = AppConfig._private();
  Environment env = Environment.env();
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

  static String promotionExchange(String id) =>
      '/member/promotion/$id/exchange';

  // Member data
  static const String memberDataPointHistory = '/member-data/point-history';

  // Product
  static const String productAll = '/member/product/all';
  static const String productSuggestion = '/member/product/suggestion';

  static String productFavoriteUpdate(String id) =>
      '/member/product/$id/favorite';
  static const String productFavoriteAll = '/member/product/favorite/all';
  static const String productCategoryAll = '/member/product-category';
  static const String productOptionAll = '/member/product-option/all';

  // Cart
  static String cartStatusGet(String id) => '/cart-status/$id';
  static const String cartStatusAll = '/cart-status/all';

  static String cartGet(String id) => 'member/cart/$id';

  static String cartReview(String id) => '/member/cart/$id/review';
  static const String cartCheckVoucher = '/member/cart/check-voucher';
  static const String cartCreate = '/member/cart/create';

  // Cart template
  static const String cartTemplateAll = '/member/cart-template/all';
  static const String cartTemplate = 'member/cart-template';

  static String cartTemplatePut(String id) => '/member/cart-template/$id';
  static const String cartTemplateArrange = '/member/cart-template/arrange';

  static String cartTemplateDelete(String id) => '/member/cart-template/$id';

  // News
  static const String news = 'member/news';

  // Store
  static const String storeShort = '/member/store/short';

  static String storeGet(String id) => '/member/store/$id';

  static String storeFavoritePatch(String id) => '/member/store/$id/favorite';

  // Notify
  static const String notificationAll = '/member/notification/all';

  static String notificationCheckPatch(String id) =>
      '/member/notification/$id/check';

  static String notificationCheckAll = '/member/notification/check-all';

  // Setting
  static const String settingProfile = '/member/setting/profile';
  static const String settingAddress = '/member/setting/address';

  static String settingAddressUpdate(String id) =>
      '/member/setting/address/$id';

  static String settingAddressDelete(String id) =>
      '/member/setting/address/$id';
  static const String settingNotification = '/member/setting/notification';
}
