import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/provider/profile_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/provider/home_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/provider/topup_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/provider/transaction_provider.dart';
import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'core/di/init_dependencies.dart';
import 'features/auth/presentation/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => serviceLocator<AuthProvider>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ProfileProvider>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<TopupProvider>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<TransactionProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SIMS PPOB-Richard Albert Salendah',
      theme: AppTheme.themeMode,
      routerConfig: router(context),
    );
  }
}
