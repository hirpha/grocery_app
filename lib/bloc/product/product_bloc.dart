import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/models/product.dart';

import '../../models/category.dart';
import '../../repository/product_repo.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductLoading()) {
    on<ProductsLoadEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        final product = await productRepository.getProducts();
        emit(ProductsLoadEventSuccess(product: product));
      } catch (e) {
        emit(ProductLoadFaulure(reason: e.toString()));
      }
    });
    on<ProductLoad>((event, emit) async {
      try {
        emit(ProductLoading());
        final product = await productRepository.getSingleProduct(event.id!);
        emit(ProductLoadSuccess(product: product));
      } catch (e) {
        emit(ProductLoadFaulure(reason: e.toString()));
      }
    });
  }
}

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
