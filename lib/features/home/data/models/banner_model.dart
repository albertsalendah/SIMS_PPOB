import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/banners.dart';

class BannerModel extends Banners {
  BannerModel({
    required super.bnrName,
    required super.bnrImage,
    required super.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bnrName: json['banner_name'],
      bnrImage: json['banner_image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'banner_name': bnrName,
      'banner_image': bnrImage,
      'description': description,
    };
  }

  BannerModel copyWith({
    String? bnrName,
    String? bnrImage,
    String? description,
  }) {
    return BannerModel(
      bnrName: bnrName ?? this.bnrName,
      bnrImage: bnrImage ?? this.bnrImage,
      description: description ?? this.description,
    );
  }
}
