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

class RouteApi {
  static const String login = '/login';
  static const String register = '/register';
  static const String refresh = '/refresh';
  static const String slider = '/sliders';
}
