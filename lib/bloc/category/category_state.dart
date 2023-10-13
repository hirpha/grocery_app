import 'package:equatable/equatable.dart';

import '../../models/category.dart';

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
