import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/banners.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';

import 'package:sims_ppob_richard_albert_salendah/features/home/domain/usecases/get_banner.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/usecases/get_menu.dart';

enum HomeStatus { initial, loading, bannerSuccess, menusSuccess, error }

class HomeProvider with ChangeNotifier {
  final GetBanner getBanner;
  final GetMenu getMenu;
  HomeProvider({
    required this.getBanner,
    required this.getMenu,
  });

  HomeStatus _status = HomeStatus.initial;
  String? _message;
  List<Banners>? _banner;
  List<Menus>? _menu;

  HomeStatus get status => _status;
  String? get message => _message;
  List<Banners>? get banner => _banner;
  List<Menus>? get menu => _menu;

  Future<void> getBanners({required String token}) async {
    _setStatus(HomeStatus.loading);
    final result = await getBanner(token);
    result.fold((failure) {
      _setStatus(HomeStatus.error, message: failure.message);
      resetState();
    }, (success) {
      _banner = success.data;
      _setStatus(HomeStatus.bannerSuccess, message: success.message);
      resetState();
    });
  }

  Future<void> geMenus({required String token}) async {
    _setStatus(HomeStatus.loading);
    final result = await getMenu(token);
    result.fold((failure) {
      _setStatus(HomeStatus.error, message: failure.message);
      resetState();
    }, (success) {
      _menu = success.data;
      _setStatus(HomeStatus.bannerSuccess, message: success.message);
      resetState();
    });
  }

  void _setStatus(HomeStatus status, {String? message}) {
    _status = status;
    _message = message;
    notifyListeners();
  }

  void resetState() {
    _setStatus(HomeStatus.initial);
  }
}
