import 'package:crypto_coin/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'models/crypto_coin_details.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
    required this.cryptoCoinBox,
  });
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinBox;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    try {
      final cryptoCoinsList = await _fetchCoinsListFromApi();
      final cryptoCoinMap = {for (var e in cryptoCoinsList) e.name: e};
      await cryptoCoinBox.putAll(cryptoCoinMap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinBox.values.toList();
    }
    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,DOV &tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      // final price = usdData['PRICE'];
      // final imageurl = usdData['IMAGEURL'];
      final details = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(
        name: e.key,
        details: details,
      );
      // priceInUSD: price,
      // imageUrl: 'https://www.cryptocompare.com/$imageurl');
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinsDetails(String currency) async {
    try {
      final coin = await _fetchCoinDetailFromApi(currency);
      cryptoCoinBox.put(currency, coin);
      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return cryptoCoinBox.get(currency)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailFromApi(String currency) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currency&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final dataDetail = dataRaw[currency] as Map<String, dynamic>;
    final dataDetailUSD = dataDetail['USD'] as Map<String, dynamic>;

    final details = CryptoCoinDetail.fromJson(dataDetailUSD);

    return CryptoCoin(
      name: currency, details: details,
      // priceInUSD: dataDetailUSD['PRICE'],
      // imageUrl: 'https://www.cryptocompare.com/${dataDetailUSD['IMAGEURL']}',
      // hight24Hour: dataDetailUSD['HIGH24HOUR'],
      // low24Hours: dataDetailUSD['LOW24HOUR'],
    );
  }
}
