import '../models/slider_model.dart';

class SliderRepository {
  List<SliderModel> sliders = [];

  Future<bool> fetchSliders() async {
    // Api.notAuthDio.get(RouteApi.slider);
    Future.delayed(const Duration(seconds: 1));
    sliders = [
      SliderModel(
        image:
            'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
        voucherID: 'SLD-0001',
      ),
      SliderModel(
        image:
            'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
        voucherID: 'SLD-0001',
      ),
      SliderModel(
        image:
            'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
        voucherID: 'SLD-0001',
      ),
      SliderModel(
        image:
            'https://static.vecteezy.com/system/resources/previews/002/909/345/non_2x/bubble-milk-tea-special-promotions-design-boba-milk-tea-pearl-milk-tea-yummy-drinks-coffees-and-soft-drinks-with-logo-and-cute-funny-doodle-style-advertisement-banner-illustration-vector.jpg',
        voucherID: 'SLD-0001',
      ),
    ];
    return true;
  }
}
