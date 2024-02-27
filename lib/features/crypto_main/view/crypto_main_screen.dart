import 'package:flutter/material.dart';

import '../widgets/crypto_coin_tile.dart';

class CryptoMainScreen extends StatefulWidget {
  const CryptoMainScreen({
    super.key,
  });

  @override
  State<CryptoMainScreen> createState() => _CryptoMainScreenState();
}

class _CryptoMainScreenState extends State<CryptoMainScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crypto Currency App'),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          const coinName = 'Bitcoin';
          return const CryptoCoinTile(coinName: coinName);
        },
      ),
    );
  }
}

