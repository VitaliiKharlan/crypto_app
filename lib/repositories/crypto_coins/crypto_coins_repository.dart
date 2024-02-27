import 'package:dio/dio.dart';

import 'models/crypto_coin.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get<List<CryptoCoin>>(
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
