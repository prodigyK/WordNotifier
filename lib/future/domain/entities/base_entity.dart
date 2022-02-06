import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {
  final int id;

  const BaseEntity(this.id);

  @override
  List<Object> get props => [id];
}
