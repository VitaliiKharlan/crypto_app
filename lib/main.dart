import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'crypto_currency_app.dart';
import 'repositories/crypto_coins/abstract_coins_repository.dart';
import 'repositories/crypto_coins/crypto_coins_repository.dart';
import 'repositories/crypto_coins/models/crypto_coin.dart';
import 'repositories/crypto_coins/models/crypto_coin_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();
  GetIt.instance.registerSingleton(talker);
  GetIt.instance<Talker>().debug('Talker started...');

  const cryptoCoinsBoxName = 'crypto_coins_box';

  await Hive.initFlutter();

  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  GetIt.instance.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox),
  );

  FlutterError.onError = (details) =>
      GetIt.instance<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(
    () {
      // BindingBase.debugZoneErrorsAreFatal = true;
      runApp(const CryptoCurrencyApp());
    },
    (e, st) {
      GetIt.instance<Talker>().handle(e, st);
    },
  );
}
