import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/utils/Session.dart';

import '../../models/category.dart';
import '../../repository/category_repo.dart';
import 'category_event.dart';
import 'category_state.dart';

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
