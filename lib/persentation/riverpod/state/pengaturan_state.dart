
import 'package:equatable/equatable.dart';
class PengaturanState extends Equatable {
  final bool isActive;
  const PengaturanState(this.isActive);

  @override
  List<Object?> get props => [isActive];
}