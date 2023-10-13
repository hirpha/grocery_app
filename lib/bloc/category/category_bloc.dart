import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/utils/Session.dart';

import '../../models/category.dart';
import '../../repository/category_repo.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryLoading()) {
    on<CategoryLoad>((event, emit) async {
      try {
        emit(CategoryLoading());
        final categories = await categoryRepository.categoryLoad();
        Session().logSession("..........", categories.toString());
        emit(CategoryLoadSuccess(categories: categories));
      } catch (e) {
        emit(CategoryLoadFaulure(reason: e.toString()));
      }
    });
  }
}

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class CategoryLoad extends CategoryEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final List<Category>? categories;
  const CategoryLoadSuccess({this.categories});
}

class CategoryLoadFaulure extends CategoryState {
  final String? resaon;
  const CategoryLoadFaulure({this.resaon, required String reason});
}
