import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sims_ppob_richard_albert_salendah/config/routes/routes_name.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/di/init_dependencies.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/navigation_item_data.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/provider/profile_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/pages/home_page.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/provider/home_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/pages/profile_page.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/pages/topup_page.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/provider/topup_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/pages/transaction_page.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/provider/transaction_provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late AuthProvider _authProvider;
  int _selectedIndex = 0;
  String? token;
  PageController _pageController = PageController();
  List<NavigationItemData> _navigationItems = [];
  bool finishLoading = false;

  @override
  void initState() {
    _navigationItems = [
      NavigationItemData(
        icon: Icons.home,
        label: 'Home',
        page: HomePage(
          toProfile: _toProfile,
        ),
      ),
      NavigationItemData(
          icon: Icons.money_rounded,
          label: 'Top Up',
          page: TopupPage(toHome: _toHome)),
      NavigationItemData(
          icon: Icons.credit_card,
          label: 'Transaction',
          page: TransactionPage(toHome: _toHome)),
      NavigationItemData(
          icon: Icons.person,
          label: 'Akun',
          page: ProfilePage(toHome: _toHome)),
    ];
    _pageController = PageController(initialPage: _selectedIndex);
    _authProvider = serviceLocator<AuthProvider>();
    token = _authProvider.getToken();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        if (token != null) {
          await loadData().then((v) {
            finishLoading = true;
            setState(() {});
          });
          _checkTokenExpiration();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    await serviceLocator<ProfileProvider>().getUser(token: token!);
    await serviceLocator<TopupProvider>().getBalance(token: token!);
    await serviceLocator<HomeProvider>().geMenus(token: token!);
    await serviceLocator<HomeProvider>().getBanners(token: token!);
    await serviceLocator<TransactionProvider>()
        .getTransactions(token: token!, offset: 0, limit: 5);
  }

  void _checkTokenExpiration() {
    final isExpired = token != null ? JwtDecoder.isExpired(token!) : true;
    log('NavBar check token if expired :$isExpired');
    if (isExpired) {
      _authProvider.logout();
      final token = _authProvider.getToken();
      if (token == null) {
        context.goNamed(RoutesName.login);
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _checkTokenExpiration();
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _toHome() {
    setState(() {
      _selectedIndex = 0;
      _pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _checkTokenExpiration();
    });
  }

  void _toProfile() {
    setState(() {
      _selectedIndex = 3;
      _pageController.animateToPage(
        3,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _checkTokenExpiration();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
        backgroundColor: AppPallete.whiteColor,
        elevation: 2,
        currentIndex: _selectedIndex,
        selectedItemColor: AppPallete.black,
        unselectedItemColor: AppPallete.greyColor,
        onTap: finishLoading ? _onItemTapped : null,
        type: BottomNavigationBarType.fixed,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _checkTokenExpiration();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  _checkTokenExpiration();
                });
              },
              children: _navigationItems.map((item) {
                return RefreshIndicator(
                    backgroundColor: AppPallete.whiteColor,
                    color: AppPallete.red,
                    onRefresh: () async {
                      final index = _navigationItems.indexOf(item);
                      if (index == 0) {
                        await loadData();
                      } else if (index == 1) {
                        await serviceLocator<TopupProvider>()
                            .getBalance(token: token!);
                      } else if (index == 2) {
                        await serviceLocator<TransactionProvider>()
                            .getTransactions(
                                token: token!, offset: 0, limit: 5);
                      } else if (index == 3) {
                        await serviceLocator<ProfileProvider>()
                            .getUser(token: token!);
                      }
                    },
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: item.page));
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
