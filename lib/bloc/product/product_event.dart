import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductsLoadEvent extends ProductEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductLoad extends ProductEvent {
  String? id;
  ProductLoad({required this.id});
  @override
  List<Object?> get props => throw UnimplementedError();
}
