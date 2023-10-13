import 'package:equatable/equatable.dart';

class Product extends Equatable {
  List? bulkDeals;
  SingleDeal? singleDeal;
  GroupDeal? groupDeal;
  String? name;
  bool? favorite;
  String? groupCount;
  String? measuringUnit;
  String? productStatus;
  String? longDescription;
  String? shortDescription;
  String? vendorId;
  String? categoryId;
  String? id;
  String? primaryImage;
  List detailImages;
  String createdAt;
  Product({
    required this.name,
    required this.createdAt,
    required this.detailImages,
    required this.id,
    required this.primaryImage,
    required this.shortDescription,
    required this.bulkDeals,
    required this.categoryId,
    required this.favorite,
    required this.groupCount,
    required this.groupDeal,
    required this.longDescription,
    required this.measuringUnit,
    required this.productStatus,
    required this.singleDeal,
    required this.vendorId,
  });

  @override
  List<Object?> get props => [
        name,
        detailImages,
      ];
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        createdAt: json['created_at'],
        detailImages: json['detail_images'],
        id: json['id'],
        primaryImage: json['primary_image'],
        shortDescription: json['short_description'],
        productStatus: json['product_tatus'],
        bulkDeals: json['bulk_deals'],
        categoryId: json['category_id'],
        favorite: json['favorite'],
        groupDeal: GroupDeal.fromJson(json['group_deal']),
        longDescription: json['long_description'],
        vendorId: json['vendor_id'],
        singleDeal: SingleDeal.fromJson(json['single_deal']),
        measuringUnit: json['measuring_unit'],
        groupCount: json['groupCount'].toString());
  }
}

class SingleDeal extends Equatable {
  String? originalPrice;
  String? availableQuantity;
  String? id;

  SingleDeal({
    required this.availableQuantity,
    required this.id,
    required this.originalPrice,
  });
  factory SingleDeal.fromJson(Map<String, dynamic> json) {
    return SingleDeal(
        availableQuantity: json['available_quantity'].toString(),
        id: json['id'],
        originalPrice: json['original_price'].toString());
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GroupDeal extends Equatable {
  String? groupPrice;
  String? availableQuantity;
  String? maxGroupMember;
  String? expirationTime;
  String? id;

  GroupDeal({
    required this.availableQuantity,
    required this.id,
    required this.groupPrice,
    required this.expirationTime,
    required this.maxGroupMember,
  });
  factory GroupDeal.fromJson(Map<String, dynamic> json) {
    return GroupDeal(
        availableQuantity: json['available_quantity'].toString(),
        id: json['id'],
        expirationTime: json['expiration_time'].toString(),
        maxGroupMember: json['max_group_member'].toString(),
        groupPrice: json['group_price'].toString());
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
