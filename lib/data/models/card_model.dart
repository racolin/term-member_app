import 'package:member_app/presentation/res/strings/values.dart';

class CardModel {
  final String id;
  final String name;
  final int scores;
  final String rankName;
  final String nextRankName;
  final String background;
  final String description;
  final int nextRank;
  final String status;

  CardModel({
    required this.id,
    required this.name,
    required this.scores,
    required this.rankName,
    required this.nextRankName,
    required this.background,
    required this.description,
    required this.nextRank,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'scores': scores,
      'rankName': rankName,
      'nextRankName': nextRankName,
      'background': background,
      'nextRank': nextRank,
      'status': status,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? txtUnknown,
      name: map['name'] ?? txtUnknown,
      scores: map['scores'] ?? 0,
      rankName: map['rankName'] ?? txtUnknown,
      nextRankName: map['nextRankName'] ?? txtUnknown,
      background: map['background'] ?? linkUnknownIcon,
      description: map['description'] ?? txtUnknown,
      nextRank: map['nextRank'] ?? 0,
      status: map['status'] ?? txtUnknown,
    );
  }

  CardModel copyWith({
    String? id,
    String? name,
    int? scores,
    String? rankName,
    String? nextRankName,
    String? background,
    String? description,
    int? nextRank,
    String? status,
  }) {
    return CardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      scores: scores ?? this.scores,
      rankName: rankName ?? this.rankName,
      nextRankName: nextRankName ?? this.nextRankName,
      background: background ?? this.background,
      description: description ?? this.description,
      nextRank: nextRank ?? this.nextRank,
      status: status ?? this.status,
    );
  }
}