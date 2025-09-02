import 'package:flutter/material.dart';
import '../features/wallet/presentation/pages/wallet_page.dart';
import 'constants/app_constants.dart';
import 'theme/app_theme.dart';

/// Main application widget
class WalletUpApp extends StatelessWidget {
  const WalletUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WalletPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
