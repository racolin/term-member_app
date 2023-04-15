import 'package:flutter/foundation.dart';

import '../../presentation/res/strings/values.dart';
import '../../data/models/voucher_model.dart';

@immutable
abstract class VoucherState {}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class VoucherLoaded extends VoucherState {
  final List<VoucherModel> list;
  final List<VoucherModel> used;

  VoucherLoaded({
    required this.list,
    List<VoucherModel>? used,
  }) : used = used ?? [];

  VoucherLoaded copyWith({
    List<VoucherModel>? list,
    List<VoucherModel>? used,
  }) {
    return VoucherLoaded(
      list: list ?? this.list,
      used: used ?? this.used,
    );
  }

  List<VoucherModel> getsAboutToExpire() {
    return list
        .where(
          (e) => DateTime.now().add(const Duration(days: 7)).isAfter(e.to),
        )
        .toList();
  }

  List<VoucherModel> getsAvailable() {
    return list
        .where(
          (e) =>
              e.partner.toUpperCase() == txtAppName.toUpperCase() &&
              DateTime.now().add(const Duration(days: 7)).isBefore(e.to),
        )
        .toList();
  }

  List<VoucherModel> getsFromPartner() {
    return list
        .where(
          (e) =>
              e.partner.toUpperCase() != txtAppName.toUpperCase() &&
              DateTime.now().add(const Duration(days: 7)).isBefore(e.to),
        )
        .toList();
  }
}
