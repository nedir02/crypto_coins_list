import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:crypto_coin/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coin/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coin/repositories/crypto_coins/crypto_coins.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  // zNACENIYALARYMYZY ALMAK UN LIST DOREDELIN:
  // List<CryptoCoin>? _cryptoCoinsList;

  final _cryptoListBLoc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBLoc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Crypto Currencies List",
            style: TextStyle(fontSize: 20),
          )),
          actions: [
            IconButton(
              onPressed: () {
                // context.go('/talker');
                // AutoRouter.of(context).push('/talker');
              },
              icon: const Icon(Icons.document_scanner_outlined),
              color: Colors.white,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBLoc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBLoc,
            builder: (context, state) {
              if (state is CryptoListLoaded) {
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 10),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.coinsList.length,
                  itemBuilder: (context, i) {
                    final coin = state.coinsList[i];
                    return CryptoCoinTile(coin: coin);
                  },
                );
              }
              if (state is CryptoListLoadingFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Näsazlyk ýüze çykdy...',
                        style: theme.textTheme.headlineMedium,
                      ),
                      Text('Internedi barlaň...',
                          style: theme.textTheme.labelSmall
                              ?.copyWith(fontSize: 16)),
                      const SizedBox(height: 30),
                      TextButton(
                          onPressed: () {
                            _cryptoListBLoc.add(LoadCryptoList());
                          },
                          child: const Text('Täzeden synanyş'))
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        )

        //  (_cryptoCoinsList == null)
        //     ? const Center(child: CircularProgressIndicator())

        );
  }
}
