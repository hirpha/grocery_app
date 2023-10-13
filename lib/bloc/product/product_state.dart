import 'package:equatable/equatable.dart';

import '../../models/product.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductsLoadEventSuccess extends ProductState {
  List<Product>? product;
  ProductsLoadEventSuccess({this.product});
}

class ProductLoadSuccess extends ProductState {
  Product? product;
  ProductLoadSuccess({this.product});
}

class ProductLoadFaulure extends ProductState {
  final String? resaon;
  const ProductLoadFaulure({this.resaon, required String reason});
}
