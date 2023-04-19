import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cart_model.dart';
import '../../exception/app_exception.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/store_detail_model.dart';
import '../../data/models/store_model.dart';
import '../../data/models/voucher_model.dart';
import '../../exception/app_message.dart';
import '../repositories/cart_repository.dart';
import '../states/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit({required CartRepository repository})
      : _repository = repository,
        super(CartInitial()) {
    /// Thiếu bước lưu cart local khi login thì nạp lại
    emit(CartLoaded(products: [], categoryId: DeliveryType.takeOut));
  }

  Future<AppMessage?> checkAndSetVoucher(VoucherModel voucher) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    if (state.categoryId == null) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Thông báo',
        content: 'Bạn phải chọn hình thức giao hàng trước',
      );
    }

    try {
      CartDetailModel checked = await _checkVoucher(
        voucher.id,
        state.categoryId!.index,
        state.products,
      );

      var products = state.products.map((product) {
        int index = checked.products.indexWhere((e) => product.id == e.id);

        if (index == -1) {
          return product;
        }
        return product.copyWith(cost: checked.products[index].cost);
      }).toList();

      emit(state.copyWith(
        voucher: voucher,
        voucherDiscount: checked.voucherDiscount,
        fee: checked.fee,
        products: products,
      ));
    } on AppException catch (ex) {
      return ex.message;
    }
    return null;
  }

  Future<CartDetailModel> _checkVoucher(
    String voucherId,
    int categoryId,
    List<CartProductModel> products,
  ) async {
    CartDetailModel? checked = await _repository.checkVoucher(
      voucherId: voucherId,
      categoryId: categoryId,
      products: products,
    );

    if (checked == null) {
      throw AppException(
        message: AppMessage(
          messageType: AppMessageType.error,
          title: 'Có lỗi!',
          content: 'Voucher của bạn chưa được kiểm tra. Hãy thử lại!',
        ),
      );
    }
    return checked;
  }

  Future<AppMessage?> create() async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    if (state.categoryId == null ||
        state.payType == null ||
        state.phone == null ||
        state.phone == '' ||
        state.receiver == null ||
        state.receiver == '') {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Chưa đủ thông tin',
        content: 'Bạn chưa điền đầy đủ thông tin đơn hàng!',
      );
    }
    try {
      String? id = await _repository.create(
        categoryId: state.categoryId!.index,
        payType: state.payType!,
        phone: state.phone!,
        receiver: state.receiver!,
        products: state.products,
        addressName: '${state.addressName}|${state.addressDescription}',
        voucherId: state.voucher?.id,
      );

      if (id != null) {
        return AppMessage(
          messageType: AppMessageType.success,
          title: 'Thành công',
          content: 'Bạn đã đặt hàng thành công!',
        );
      }

      return AppMessage(
        messageType: AppMessageType.error,
        title: 'Lỗi!',
        content: 'Đơn hàng gặp trục trặc. Vui lòng thử lại!',
      );
    } on AppException catch (ex) {
      return ex.message;
    }

    return null;
  }

  AppMessage? setAddress(String addressName, String addressDescription) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      addressDescription: addressDescription,
      addressName: addressName,
    ));

    return null;
  }

  AppMessage? setStore(StoreModel store, StoreDetailModel storeDetail) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      store: store,
      storeDetail: storeDetail,
    ));

    return null;
  }

  AppMessage? setReceiver(String receiver, String phone) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      receiver: receiver,
      phone: phone,
    ));

    return null;
  }

  AppMessage? setReceiverName(String receiver) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      receiver: receiver,
    ));

    return null;
  }

  AppMessage? setPhone(String phone) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      phone: phone,
    ));

    return null;
  }

  AppMessage? editDateTime(DateTime time) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      time: time,
    ));

    return null;
  }

  AppMessage? setPayType(int payType) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    emit(state.copyWith(
      payType: payType,
    ));

    return null;
  }

  Future<AppMessage?> setCategory(int categoryId, int fee) async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        messageType: AppMessageType.failure,
        title: 'Hãy đợi',
        content: 'Thao tác của bạn quá nhanh',
      );
    }

    var state = this.state as CartLoaded;

    if (state.voucher != null) {
      try {
        CartDetailModel checked = await _checkVoucher(
          state.voucher!.id,
          categoryId,
          state.products,
        );

        emit(state.copyWith(
          categoryId: DeliveryType.values[categoryId],
          fee: fee,
        ));
      } on AppException catch(ex) {
        return ex.message;
      }
    }

    return null;
  }
}
