import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';

class MenuModel extends Menus {
  MenuModel({
    required super.menuCode,
    required super.menuName,
    required super.menuIcon,
    required super.menuTariff,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      menuCode: json['service_code'],
      menuName: json['service_name'],
      menuIcon: json['service_icon'],
      menuTariff: json['service_tariff'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'service_code': menuCode,
      'service_name': menuName,
      'service_icon': menuIcon,
      'service_tariff': menuTariff,
    };
  }

  @override
  MenuModel copyWith({
    String? menuCode,
    String? menuName,
    String? menuIcon,
    int? menuTariff,
  }) {
    return MenuModel(
      menuCode: menuCode ?? this.menuCode,
      menuName: menuName ?? this.menuName,
      menuIcon: menuIcon ?? this.menuIcon,
      menuTariff: menuTariff ?? this.menuTariff,
    );
  }
}
