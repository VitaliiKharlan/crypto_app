import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../repositories/crypto_coins/crypto_coins.dart';
import '../widgets/crypto_coin_tile.dart';

class CryptoMainScreen extends StatefulWidget {
  const CryptoMainScreen({
    super.key,
  });

  @override
  State<CryptoMainScreen> createState() => _CryptoMainScreenState();
}

class _CryptoMainScreenState extends State<CryptoMainScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crypto Currency App'),
      ),
      body: _cryptoCoinsList == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 16),
              itemCount: _cryptoCoinsList!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];

                return CryptoCoinTile(coin: coin);
              },
            ),
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList =
        await GetIt.instance<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }
}
