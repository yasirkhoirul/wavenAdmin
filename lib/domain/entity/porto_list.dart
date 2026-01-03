import 'package:equatable/equatable.dart';

class PortoList extends Equatable {
  final String message;
  final int count;
  final int page;
  final int limit;
  final List<Portfolio> portfolios;

  const PortoList({
    required this.message,
    required this.count,
    required this.page,
    required this.limit,
    required this.portfolios,
  });

  @override
  List<Object?> get props => [message, count, page, limit, portfolios];
}

class Portfolio extends Equatable {
  final String id;
  final String url;

  const Portfolio({
    required this.id,
    required this.url,
  });

  Portfolio copyWith({
    String? id,
    String? url,
  }) {
    return Portfolio(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [id, url];
}
