import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class CryptoCurrencyApp extends StatefulWidget {
  const CryptoCurrencyApp({super.key});

  @override
  State<CryptoCurrencyApp> createState() => _CryptoCurrencyAppState();
}

class _CryptoCurrencyAppState extends State<CryptoCurrencyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Currency',
      theme: darkTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.instance<Talker>()),
        ],
      ),
      // routes: routes,
    );
  }
}
