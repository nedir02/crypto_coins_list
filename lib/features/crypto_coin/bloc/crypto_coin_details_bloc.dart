import 'package:crypto_coin/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CryptoDetailsBloc extends Bloc<CryptoDetailsEvent, CryptoDetailsState> {
  CryptoDetailsBloc(this.coinsRepository) : super(CryptoDetailsInitial()) {
    on<LoadCryptoCoinDetail>((event, emit) async {
      try {
        if (state is! CryptoCoinDetailLoaded) {
          emit(CryptoCoinDetailLoading());
        }
        final dataDetailUSD =
            await coinsRepository.getCoinsDetails(event.currency);
        emit(CryptoCoinDetailLoaded(dataDetailUSD));
      } catch (e, st) {
        emit(CryptoDetailsLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }

  final AbstractCoinsRepository coinsRepository;
}
