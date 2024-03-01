part of 'crypto_main_bloc.dart';

abstract class CryptoMainState extends Equatable {}

class CryptoMainInitial extends CryptoMainState {
  @override
  List<Object?> get props => [];
}

class CryptoMainLoading extends CryptoMainState {
  @override
  List<Object?> get props => [];
}

class CryptoMainLoaded extends CryptoMainState {
  CryptoMainLoaded({
    required this.coinsMain,
  });

  final List<CryptoCoin> coinsMain;

  @override
  List<Object?> get props => [coinsMain];
}

class CryptoMainLoadingFailure extends CryptoMainState {
  CryptoMainLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
