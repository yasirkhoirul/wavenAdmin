import 'package:equatable/equatable.dart';

class AddonDetail extends Equatable {
  final String id;
  final String title;
  final int price;
  final bool isActive;
  final String createdAt;

  const AddonDetail({
    required this.id,
    required this.title,
    required this.price,
    required this.isActive,
    required this.createdAt,
  });

  AddonDetail copyWith({
    String? id,
    String? title,
    int? price,
    bool? isActive,
    String? createdAt,
  }) {
    return AddonDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, price, isActive, createdAt];
}
