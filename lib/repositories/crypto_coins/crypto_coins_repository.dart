import 'package:dio/dio.dart';

import 'crypto_coins.dart';
import 'models/crypto_coin_details.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response =
        await dio.get<Map<String, dynamic>>('https://min-api.cryptocompare.com/'
            'data/pricemultifull?fsyms='
            'BTC,BBC,ETH,BNB,AID,ACE,AOC,SOL,CAG,DOV,ANT&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;

      final details = CryptoCoinDetail.fromJson(usdData);

      return CryptoCoin(
        name: e.key,
        details: details,
      );
    }).toList();

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    final response =
        await dio.get<Response<dynamic>>('https://min-api.cryptocompare.com/'
            'data/pricemultifull?fsyms='
            'BTC&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;

    final details = CryptoCoinDetail.fromJson(usdData);

    return CryptoCoin(
      name: currencyCode,
      details: details,
    );
  }
}
