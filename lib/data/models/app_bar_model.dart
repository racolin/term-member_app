import 'package:member_app/presentation/res/strings/values.dart';

class AppBarModel {
  final String icon;
  final String label;
  final int cartTemplateAmount;
  final int ticketAmount;
  final int notifyAmount;

  const AppBarModel({
    required this.icon,
    required this.label,
    required this.cartTemplateAmount,
    required this.ticketAmount,
    required this.notifyAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'label': label,
      'cartTemplateAmount': cartTemplateAmount,
      'ticketAmount': ticketAmount,
      'notifyAmount': notifyAmount,
    };
  }

  factory AppBarModel.fromMap(Map<String, dynamic> map) {
    return AppBarModel(
      icon: map['icon'] ?? linkUnknownIcon,
      label: map['label'] ?? txtUnknown,
      cartTemplateAmount: map['cartTemplateAmount'] ?? 0,
      ticketAmount: map['ticketAmount'] ?? 0,
      notifyAmount: map['notifyAmount'] ?? 0,
    );
  }
}