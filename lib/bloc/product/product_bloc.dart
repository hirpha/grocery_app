import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/product/product_event.dart';
import 'package:grocery_app/bloc/product/product_state.dart';
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
