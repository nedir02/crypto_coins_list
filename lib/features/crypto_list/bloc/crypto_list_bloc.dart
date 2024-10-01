import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../repositories/crypto_coins/crypto_coins.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(
    this.coinsRepository,
  ) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }

        // final coinsList = await coinsRepository.getCoinsList();
      } catch (e, st) {
        emit(CryptoListLoadingFailure(exception: e));
        // Exception log edyas talker bn
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
    // Try catch dashyndaky error lary gormek un
    // @override
    // void onError(Object error, StackTrace stackTrace) {
    //   super.onError(error, stackTrace);
    //   GetIt.I<Talker>().handle(error, stackTrace);
    // }
  }
  final AbstractCoinsRepository coinsRepository;
}
