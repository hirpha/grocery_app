import 'package:equatable/equatable.dart';

class Category extends Equatable {
  String? id;
  String? status;
  String? name;
  String? shortDescription;
  String? primaryImage;
  List<dynamic> detailImages;
  String createdAt;
  Category({
    required this.name,
    required this.createdAt,
    required this.detailImages,
    required this.id,
    required this.primaryImage,
    required this.shortDescription,
    required this.status,
  });

  @override
  List<Object?> get props => [
        name,
        detailImages,
      ];
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['name'],
        createdAt: json['created_at'],
        detailImages: json['detail_images'],
        id: json['id'],
        primaryImage: json['primary_image'],
        shortDescription: json['short_description'],
        status: json['status']);
  }
}
