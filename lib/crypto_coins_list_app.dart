import 'package:crypto_coin/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'theme/theme.dart';

class CryptoCurrenciesListApp extends StatefulWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  State<CryptoCurrenciesListApp> createState() =>
      _CryptoCurrenciesListAppState();
}

class _CryptoCurrenciesListAppState extends State<CryptoCurrenciesListApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      routerConfig: _appRouter.config(
          navigatorObservers: () => [
                TalkerRouteObserver(GetIt.I<Talker>()),
              ]),
      builder: (context, child) => TalkerWrapper(
        talker: talker,
        child: child!,
      ),
      // Routes ulanjak bolsak home gerek dal
      // home: const CryptoListScreen(),
    );
  }
}
