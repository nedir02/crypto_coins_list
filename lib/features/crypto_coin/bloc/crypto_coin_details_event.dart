part of 'crypto_coin_details_bloc.dart';

abstract class CryptoDetailsEvent extends Equatable {}

class LoadCryptoCoinDetail extends CryptoDetailsEvent {
  LoadCryptoCoinDetail({
    required this.currency,
  });
  final String currency;

  @override
  List<Object?> get props => [currency];
}
