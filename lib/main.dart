import 'package:esme26/ui/router.dart';
import 'package:esme26/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _router = createRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Artisanat',
      theme: AppTheme.theme,
      routerConfig: _router,
    );
  }
}
