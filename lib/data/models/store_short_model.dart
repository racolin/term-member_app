import 'package:equatable/equatable.dart';

class StoreShortModel extends Equatable {
  final String id;
  final String mainImage;
  final String fullAddress;
  final String name;
  final String distance;

  const StoreShortModel({
    required this.id,
    required this.mainImage,
    required this.fullAddress,
    required this.name,
    required this.distance,
  });

  @override
  List<Object?> get props => [id];
}
