part of 'crypto_main_bloc.dart';

abstract class CryptoMainEvent extends Equatable {
  get completer => null;
}

class LoadCryptoMain extends CryptoMainEvent {
  LoadCryptoMain({
    required this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
