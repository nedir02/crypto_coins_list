import 'package:auto_route/auto_route.dart';
import 'package:crypto_coin/features/crypto_coin/widgets/base_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:crypto_coin/features/crypto_coin/bloc/crypto_coin_details_bloc.dart';
import 'package:crypto_coin/repositories/crypto_coins/abstract_coins_repository.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key,
    required this.coinName,
  });

  // final CryptoCoin coin;
  final String coinName;
  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final _cryptoDetailsBLoc =
      CryptoDetailsBloc(GetIt.I<AbstractCoinsRepository>());
  // String? coinName;
  // @override
  // void didChangeDependencies() {
  //   final args = ModalRoute.of(context)?.settings.arguments;
  //   assert(args != null && args is String, 'You must provide String args');
  // if (args == null) {
  //   log('You must provide args');
  //   return;
  // }
  // if (args is! String) {
  //   log('You must provide String args');
  //   return;
  // }
  //   coinName = args as String;
  //   setState(() {});

  // }

  @override
  void initState() {
    _cryptoDetailsBLoc.add(LoadCryptoCoinDetail(currency: widget.coinName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.coinName)),
      ),
      body: BlocBuilder<CryptoDetailsBloc, CryptoDetailsState>(
        bloc: _cryptoDetailsBLoc,
        builder: (context, state) {
          if (state is CryptoCoinDetailLoaded) {
            final coin = state.coin;
            final coinDetails = coin.details;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.network(coinDetails.fullImageUrl),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    coin.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BaseCard(
                    child: Center(
                      child: Text(
                        '${coinDetails.priceInUSD} \$',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  BaseCard(
                    child: Column(
                      children: [
                        _DataRow(
                          title: 'Hight 24 Hour',
                          value: '${coinDetails.hight24Hour} \$',
                        ),
                        const SizedBox(height: 6),
                        _DataRow(
                          title: 'Low 24 Hour',
                          value: '${coinDetails.low24Hours} \$',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is CryptoDetailsLoadingFailure) {
            final theme = Theme.of(context);
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
                      style:
                          theme.textTheme.labelSmall?.copyWith(fontSize: 16)),
                  const SizedBox(height: 30),
                  TextButton(
                      onPressed: () {
                        _cryptoDetailsBLoc.add(
                            LoadCryptoCoinDetail(currency: widget.coinName));
                      },
                      child: const Text('Täzeden synanyş'))
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _cryptoDetailsBLoc
      //         .add(LoadCryptoCoinDetail(currency: widget.coinName));
      //     setState(() {});
      //   },
      //   child: const Icon(Icons.download),
      // ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}
