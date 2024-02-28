import 'package:dio/dio.dart';

import 'crypto_coins.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get<Map<String, dynamic>>(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms='
        'BTC,BBC,ETH,BNB,AID,ACE,AOC,SOL,CAG,DOV,ANT&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'] as double;
      final imageUrl = usdData['IMAGEURL'] as String;

      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      );
    }).toList();

    return cryptoCoinsList;
  }
}
