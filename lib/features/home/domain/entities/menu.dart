// ignore_for_file: public_member_api_docs, sort_constructors_first
class Menus {
  final String menuCode;
  final String menuName;
  final String menuIcon;
  final int menuTariff;
  Menus({
    required this.menuCode,
    required this.menuName,
    required this.menuIcon,
    required this.menuTariff,
  });

  Menus copyWith({
    String? menuCode,
    String? menuName,
    String? menuIcon,
    int? menuTariff,
  }) {
    return Menus(
      menuCode: menuCode ?? this.menuCode,
      menuName: menuName ?? this.menuName,
      menuIcon: menuIcon ?? this.menuIcon,
      menuTariff: menuTariff ?? this.menuTariff,
    );
  }
}
