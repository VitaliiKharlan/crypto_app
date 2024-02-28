part of 'crypto_main_bloc.dart';

class CryptoMainState {}

class CryptoMainInitial extends CryptoMainState {}

class CryptoMainLoading extends CryptoMainState {
  // @override
  // List<Object?> get props => [];
}

class CryptoMainLoaded extends CryptoMainState {
  CryptoMainLoaded({
    required this.coinsMain,
  });

  final List<CryptoCoin> coinsMain;



//   @override
//   List<Object?> get props => [coinsList];
// }

}

class CryptoMainLoadingFailure extends CryptoMainState {
  CryptoMainLoadingFailure({
    this.exception,
  });

  final Object? exception;

  // @override
  // List<Object?> get props => [exception];


//
//   final Object? exception;
//
//   @override
//   List<Object?> get props => [exception];
}