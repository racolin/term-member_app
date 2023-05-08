import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/data/models/response_model.dart';

import '../../data/models/cart_model.dart';
import '../../exception/app_exception.dart';
import '../../data/models/cart_detail_model.dart';
import '../../data/models/store_detail_model.dart';
import '../../data/models/store_model.dart';
import '../../data/models/voucher_model.dart';
import '../../exception/app_message.dart';
import '../../presentation/res/strings/values.dart';
import '../repositories/cart_repository.dart';
import '../states/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit({required CartRepository repository})
      : _repository = repository,
        super(CartInitial()) {
    /// Thiếu bước lưu cart local khi login thì nạp lại
    emit(CartLoaded(
      products: [
        CartProductModel(
          id: 'id',
          name: 'name',
          cost: 25000,
          options: ['OPTION-1-1'],
          amount: 2,
          note: 'note',
        ),
        CartProductModel(
          id: 'id',
          name: 'name',
          cost: 25000,
          options: ['OPTION-1-1'],
          amount: 2,
          note: 'note',
        ),
        CartProductModel(
          id: 'id',
          name: 'name',
          cost: 25000,
          options: ['OPTION-1-1'],
          amount: 2,
          note: 'note',
        ),
      ],
      categoryId: DeliveryType.takeOut,
      fee: 18000,
    ));
  }

  // base method: return response model, use to avoid repeat code.

  Future<ResponseModel<CartDetailModel>> _checkVoucher(
    String voucherId,
    int categoryId,
    List<CartProductModel> products,
  ) async {
    var res = await _repository.checkVoucher(
      voucherId: voucherId,
      categoryId: categoryId,
      products: products,
    );

    return res;
  }

  // action method, change state and return AppMessage?, null when success

  // get data method: return model if state is loaded, else return null

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

    if (res.type == AppMessageType.success) {
      var checked = res.data;
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
      return null;
    } else {
      return res.message;
    }
  }

  Future<AppMessage?> create() async {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
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
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: 'Bạn chưa điền đầy đủ thông tin đơn hàng!',
      );
    }
    var res = await _repository.create(
      categoryId: state.categoryId!.index,
      payType: state.payType!,
      phone: state.phone!,
      receiver: state.receiver!,
      products: state.products,
      addressName: '${state.addressName}|${state.addressDescription}',
      voucherId: state.voucher?.id,
    );

    if (res.type == AppMessageType.success) {
      return AppMessage(
        type: AppMessageType.success,
        title: 'Thành công',
        content: 'Bạn đã đặt hàng thành công!',
      );
    } else {
      return res.message;
    }
  }

  AppMessage? setAddress(String addressName, String addressDescription) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
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
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
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

  AppMessage? editDateTime(DateTime time) {
    if (this.state is! CartLoaded) {
      return AppMessage(
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
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
        type: AppMessageType.failure,
        title: txtFailureTitle,
        content: txtToFast,
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

      if (res.type == AppMessageType.success) {
        emit(state.copyWith(
          categoryId: DeliveryType.values[categoryId],
          fee: fee,
        ));
        return null;
      } else {
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
}
