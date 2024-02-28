import 'package:crypto_app/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/crypto_coins/abstract_coins_repository.dart';

part 'crypto_main_event.dart';

part 'crypto_main_state.dart';

class CryptoMainBloc extends Bloc<CryptoMainEvent, CryptoMainState> {
  CryptoMainBloc(this.coinsRepository) : super(CryptoMainInitial()) {
    on<CryptoMainEvent>((event, emit) async {
      try {
        final coinsMain =
            await coinsRepository.getCoinsList();
        emit(CryptoMainLoaded(coinsMain: coinsMain));
      } catch (e) {
        emit(CryptoMainLoadingFailure(exception: e));
      }

    });
  }

  final AbstractCoinsRepository coinsRepository;
}

//
//   Future<void> _load(
//       LoadCryptoList event,
//       Emitter<CryptoListState> emit,
//       ) async {
//     try {
//       if (state is! CryptoListLoaded) {
//         emit(CryptoListLoading());
//       }
//       final coinsList = await coinsRepository.getCoinsList();
//       emit(CryptoListLoaded(coinsList: coinsList));
//     } catch (e, st) {
//       emit(CryptoListLoadingFailure(exception: e));
//       GetIt.I<Talker>().handle(e, st);
//     } finally {
//       event.completer?.complete();
//     }
//   }
//
//   @override
//   void onError(Object error, StackTrace stackTrace) {
//     super.onError(error, stackTrace);
//     GetIt.I<Talker>().handle(error, stackTrace);
//   }
// }
