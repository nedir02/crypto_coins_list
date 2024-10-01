part of 'crypto_coin_details_bloc.dart';

abstract class CryptoDetailsState extends Equatable {}

class CryptoDetailsInitial extends CryptoDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailLoading extends CryptoDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailLoaded extends CryptoDetailsState {
  CryptoCoinDetailLoaded(
    this.coin,
  );
  final CryptoCoin coin;

  @override
  List<Object?> get props => [coin];
}

class CryptoDetailsLoadingFailure extends CryptoDetailsState {
  CryptoDetailsLoadingFailure({
    this.exception,
  });
  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
