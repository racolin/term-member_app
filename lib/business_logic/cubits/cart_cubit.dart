import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../data/models/cart_checked_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/product_category_model.dart';
import '../../data/models/store_detail_model.dart';
import '../../data/models/store_model.dart';
import '../../data/models/voucher_model.dart';
import '../../data/services/secure_storage.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/cart_repository.dart';
import '../states/cart_state.dart';

enum CheckReorderType {
  success,
  unavailable,
  unknown,
}

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;
  final SecureStorage _storage = SecureStorage();

  CartCubit({
    required CartRepository repository,
  })  : _repository = repository,
        super(CartInitial()) {
    _storage.getCartLoaded().then((res) {
      if (res.type == ResponseModelType.success) {
        emit(res.data.copyWith(receivingTime: null));
      } else {
        emit(CartFailure(message: res.message));
      }
    });

    /// Thiếu bước lưu cart local khi login thì nạp lại
    ///
    ///
  }

  DeliveryType? get categoryId {
    if (state is! CartLoaded) {
      return null;
    }
    return (state as CartLoaded).categoryId;
  }

  Future<ResponseModel<bool>> saveCartLoaded() async {
    if (state is! CartLoaded) {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.error,
          title: txtErrorTitle,
          content: 'Không thể lưu đơn hàng!',
        ),
      );
    }
    var res = await _storage.persistCartLoaded(state as CartLoaded);
    if (res.type == ResponseModelType.success) {
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: res.data,
      );
    } else {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: res.message,
      );
    }
  }

  Future<ResponseModel<bool>> loadCartLoaded() async {
    var res = await _storage.getCartLoaded();
    if (res.type == ResponseModelType.success) {
      emit(res.data);
      return ResponseModel<bool>(
        type: ResponseModelType.success,
        data: true,
      );
    } else {
      return ResponseModel<bool>(
        type: ResponseModelType.failure,
        message: res.message,
      );
    }
  }

  // base method: return response model, use to avoid repeat code.

  Future<ResponseModel<CartCheckedModel>> _checkVoucher(
    String voucherId,
    int categoryId,
    List<CartProductModel> products,
  ) async {
    var storeId =
        (state is! CartLoaded) ? null : (state as CartLoaded).store?.id;
    var res = await _repository.checkVoucher(
      // storeId: storeId ?? '641875ec7541eda7125936bf',
      storeId: storeId,
      voucherId: voucherId,
      categoryId: categoryId,
      products: products,
    );

    return res;
  }

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

  Future<ResponseModel<String>> create() async {
    if (this.state is! CartLoaded) {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: txtFailureTitle,
          content: txtToFast,
        ),
      );
    }

    var state = this.state as CartLoaded;

    if (state.categoryId == DeliveryType.delivery) {
      if (
          // state.payType == null ||
          // state.time == null ||
          state.phone == null ||
              state.phone == '' ||
              state.receiver == null ||
              state.receiver == '') {
        return ResponseModel<String>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.failure,
            title: txtFailureTitle,
            content: 'Bạn chưa điền đầy đủ thông tin đơn hàng!',
          ),
        );
      }
    } else if (state.categoryId == DeliveryType.takeOut) {
      if (state.store == null || state.storeDetail == null
          // state.payType == null ||
          // state.time == null
          // ||
          // state.phone == null ||
          // state.phone == '' ||
          // state.receiver == null ||
          // state.receiver == ''
          ) {
        return ResponseModel<String>(
          type: ResponseModelType.failure,
          message: AppMessage(
            type: AppMessageType.failure,
            title: txtFailureTitle,
            content: 'Bạn chưa điền đầy đủ thông tin đơn hàng!',
          ),
        );
      }
    } else {
      return ResponseModel<String>(
        type: ResponseModelType.failure,
        message: AppMessage(
          type: AppMessageType.failure,
          title: txtFailureTitle,
          content: 'Bạn chưa điền đầy đủ thông tin đơn hàng!',
        ),
      );
    }

    var res = await _repository.create(
      storeId: state.store?.id ?? '641875ec7541eda7125936bf',
      categoryId: state.categoryId!.index,
      payType: state.payType ?? 0,
      phone: state.phone ?? '+84868754872',
      receiver: state.receiver ?? 'Vinh',
      receivingTime: state.receivingTime?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      products: state.products,
      addressName: '${state.addressName}',
      voucherId: state.voucher?.id,
      addressLat: state.addressLat,
      addressLng: state.addressLng,
    );

    clear();
    return res;
  }

  Future<AppMessage?> cancelOrder(String id) async {
    var res = await _repository.cancelOrder(id: id);

    if (res.type == ResponseModelType.success) {
      clear();
      return AppMessage(
        type: AppMessageType.success,
        title: 'Thành công',
        content: 'Bạn đã huỷ đơn thành công!',
      );
    } else {
      return res.message;
    }
  }

  void clear() {
    emit(CartLoaded(products: []));
  }

  bool emptyCart() {
    if (state is! CartLoaded) {
      return true;
    }
    return (state as CartLoaded).products.isEmpty;
  }

  AppMessage? setStore(
    StoreModel store,
    StoreDetailModel storeDetail,
    List<ProductCategoryModel> categories,
  ) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;
    var uO = storeDetail.unavailableOptions;
    var uP = storeDetail.unavailableProducts;
    var uC = storeDetail.unavailableCategories;

    for (var category in categories) {
      if (uC.contains(category.id)) {
        uP += category.productIds;
      }
    }

    /// Xoá những sản phẩm, topping không có
    var products = state.products.where((e) => !uP.contains(e.id)).toList();

    for (var product in products) {
      product.copyWith(
          options: product.options.where((o) => !uO.contains(o)).toList());
    }

    emit(state.copyWith(
      store: store,
      storeDetail: storeDetail,
      products: products,
    ));

    return null;
  }

  Future<AppMessage?> setCategory(int categoryId) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    if (state.voucher != null) {
      var res = await _checkVoucher(
        state.voucher!.id,
        categoryId,
        state.products,
      );

      if (res.type == ResponseModelType.success) {
        emit(state.copyWith(
          categoryId: DeliveryType.values[categoryId],
        ));
        return null;
      } else {
        emit(state.copyWith(
          categoryId: DeliveryType.values[categoryId],
          voucher: null,
          voucherDiscount: null,
        ));
        return res.message;
      }
    } else {
      emit(state.copyWith(
        categoryId: DeliveryType.values[categoryId],
        // fee: fee,
      ));
      return null;
    }
  }

  AppMessage? setPayType(int payType) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;
    // printpayType);
    // print'payType');
    emit(state.copyWith(
      payType: payType,
    ));

    return null;
  }

  AppMessage? setPhone(String phone) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      phone: phone,
    ));

    return null;
  }

  AppMessage? setReceiverName(String receiver) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      receiver: receiver,
    ));

    return null;
  }

  AppMessage? setReceiver(String receiver, String phone) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      receiver: receiver,
      phone: phone,
    ));

    return null;
  }

  Future<AppMessage?> checkAndSetVoucher(VoucherModel voucher) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    if (state.categoryId == null) {
      return AppMessage(
        type: AppMessageType.failure,
        title: 'Thông báo',
        content: 'Bạn phải chọn hình thức giao hàng trước',
      );
    }

    var res = await _checkVoucher(
      voucher.id,
      state.categoryId!.index,
      state.products,
    );

    if (res.type == ResponseModelType.success) {
      var checked = res.data;
      var products = state.products.map((product) {
        int index = checked.products.indexWhere(
          (e) => product.id == e.id,
        );

        if (index == -1) {
          return product;
        }
        return product.copyWith(cost: checked.products[index].cost);
      }).toList();

      emit(state.copyWith(
        voucher: voucher,
        voucherDiscount: checked.voucherDiscount,
        fee: checked.fee,
        originalFee: checked.originalFee,
        products: products,
      ));
      return null;
    } else {
      return res.message;
    }
  }

  AppMessage? setReceivingTime(DateTime? receivingTime) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      receivingTime: receivingTime,
    ));

    return null;
  }

  AppMessage? setAddress(
    String addressName,
    String distanceString,
    double lat,
    double lng,
  ) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      distanceString: distanceString,
      addressName: addressName,
      addressLat: lat,
      addressLng: lng,
    ));

    return null;
  }

  Future<AppMessage?> addProductsToCart(
    List<CartProductModel> products, [
    bool clear = true,
  ]) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.notify,
        title: txtNotifyTitle,
        content: 'Dữ liệu chưa được tải. Hãy thử lại!',
      );
    }
    var state = this.state as CartLoaded;

    var unavailableProducts = state.storeDetail?.unavailableProducts ?? [];
    var unavailableOptions = state.storeDetail?.unavailableOptions ?? [];

    var available = true;
    for (var product in products) {
      if (available) {
        if (!unavailableProducts.contains(product.id)) {
          for (var option in product.options) {
            if (unavailableOptions.contains(option)) {
              available = false;
            }
          }
        } else {
          available = false;
        }
      }
    }

    if (clear) {
      state = state.copyWith(products: []);
      state.products.addAll(products);
    }

    if (!available) {
      state = state.copyWith(
        store: null,
        storeDetail: null,
      );
      var map = state.toMap();
      map['store'] = null;
      map['storeDetail'] = null;
      map['categoryId'] = null;
      state = CartLoaded.fromMap(map);
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content:
            'Đã bỏ chọn cửa hàng vì sản phẩm được thêm không nằm trong cửa hàng.',
      );
    }

    if (state.voucher != null) {
      var mes = await checkAndSetVoucher(state.voucher!);
      if (mes != null) {
        emit(state.clearVoucher());
        // return mes;
      }
    }

    // printproducts.map((e) => e.toMap()).toList());
    // printstate.products.map((e) => e.toMap()).toList());
    emit(state);
    return null;
  }

  Future<AppMessage?> deleteProduct(CartProductModel model) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    var check = state.products.remove(model);

    if (check) {
      emit(state.copyWith());
      if (state.voucher != null) {
        var mes = await checkAndSetVoucher(state.voucher!);
        if (mes != null) {
          emit(state.clearVoucher());
          // return mes;
        }
      }
      return null;
    } else {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: 'Không tìm thấy sản phẩm trong đơn hàng!',
      );
    }
  }

  Future<AppMessage?> addProductToCart(CartProductModel model) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.notify,
        title: txtNotifyTitle,
        content: 'Dữ liệu chưa được tải. Hãy thử lại!',
      );
    }
    var state = this.state as CartLoaded;

    var index = state.products.indexOf(model);

    if (index == -1) {
      emit(state.copyWith(products: state.products + [model]));
    } else {
      var m = state.products[index].copyWith(
        amount: state.products[index].amount + model.amount,
      );
      var list = [...state.products];
      list[index] = m;
      emit(state.copyWith(products: list));
    }

    if (state.voucher != null) {
      var mes = await checkAndSetVoucher(state.voucher!);
      if (mes != null) {
        emit(state.clearVoucher());
        // return mes;
      }
    }

    return null;
  }

  Future<AppMessage?> updateProductToCart(
      CartProductModel oModel, CartProductModel nModel) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.notify,
        title: txtNotifyTitle,
        content: 'Dữ liệu chưa được tải. Hãy thử lại!',
      );
    }
    var state = this.state as CartLoaded;

    var index = state.products.indexOf(oModel);

    if (index == -1) {
      return AppMessage(
        type: AppMessageType.notify,
        title: txtNotifyTitle,
        content: 'Dữ liệu chưa được tải. Hãy thử lại!',
      );
    } else {
      var list = [...state.products];
      list[index] = nModel;
      emit(state.copyWith(products: list));
    }

    if (state.voucher != null) {
      var mes = await checkAndSetVoucher(state.voucher!);
      if (mes != null) {
        emit(state.clearVoucher());
        // return mes;
      }
    }

    return null;
  }

  AppMessage? setFee(int fee) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      fee: fee,
    ));

    return null;
  }

  Future<List<CartDetailModel>> getDetails(List<String> ids) async {
    var reses =
        await Future.wait(ids.map((id) => _repository.getDetailById(id: id)));

    var rs = <CartDetailModel>[];

    for (var i = 0; i < ids.length; i++) {
      if (reses[i].type == ResponseModelType.success) {
        rs.add(reses[i].data);
      }
    }
    return rs;
  }
}
