import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'crypto_currency_app.dart';
import 'repositories/crypto_coins/abstract_coins_repository.dart';
import 'repositories/crypto_coins/crypto_coins_repository.dart';

void main() {
  GetIt.instance.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinsRepository(dio: Dio()));

  runApp(const CryptoCurrencyApp());
}
