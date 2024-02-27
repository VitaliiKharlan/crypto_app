import 'package:flutter/material.dart';

import 'router/router.dart' show routes;
import 'theme/theme.dart' show darkTheme;

class CryptoCurrencyApp extends StatelessWidget {
  const CryptoCurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Currency',
      theme: darkTheme,
      routes: routes,
    );
  }
}