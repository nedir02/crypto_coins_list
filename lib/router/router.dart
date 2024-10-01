import 'package:auto_route/auto_route.dart';
import 'package:crypto_coin/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_coin/features/crypto_list/crypto_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart'; // For Talker DI
part 'router.gr.dart';
// final routes = {
//   '/': (context) => const CryptoListScreen(),
//   '/coin': (context) => const CryptoCoinScreen()
// };

// Get Talker instance from GetIt
final Talker talker = GetIt.I<Talker>();

// final GoRouter router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         // Log the navigation event
//         talker.info('Navigated to: Home');
//         return const CryptoListScreen();
//       },
//       routes: <RouteBase>[
//         GoRoute(
//           path: 'coin/:coin',
//           builder: (BuildContext context, GoRouterState state) {
//             final coin = state.pathParameters['coin'];
//             if (coin == null) {
//               // Log the missing coin case
//               talker.warning('Coin not found!');
//               return const Center(child: Text('Coin not found'));
//             }

//             // Log the coin navigation event
//             talker.info('Navigated to coin: $coin');
//             return CryptoCoinScreen(coinName: coin);
//           },
//         ),
//         // Add the TalkerScreen route here
//         GoRoute(
//           path: 'talker', // Define the path for TalkerScreen
//           builder: (BuildContext context, GoRouterState state) {
//             // Pass the Talker instance from GetIt to TalkerScreen
//             return TalkerScreen(talker: GetIt.I<Talker>());
//           },
//         ),
//       ],
//     ),
//   ],
// );

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}
