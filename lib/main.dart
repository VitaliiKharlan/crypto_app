import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'crypto_currency_app.dart';
import 'repositories/crypto_coins/abstract_coins_repository.dart';
import 'repositories/crypto_coins/crypto_coins_repository.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.instance.registerSingleton(talker);
  GetIt.instance<Talker>().debug('Talker started...');

  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printResponseData: false,
    ),
  ));

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  GetIt.instance.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(dio: dio),
  );

  FlutterError.onError = (details) =>
      GetIt.instance<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(
    () => runApp(const CryptoCurrencyApp()),
    (error, stack) => GetIt.instance<Talker>().handle(error, stack),
  );
}
