import 'package:equatable/equatable.dart';

import 'crypto_coin_details.dart';

class CryptoCoin extends Equatable {
  const CryptoCoin( {
    required this.name,
    required this.details,
  });

  final String name;
  final CryptoCoinDetail details;

  @override
  List<Object?> get props => [name, details];
}
