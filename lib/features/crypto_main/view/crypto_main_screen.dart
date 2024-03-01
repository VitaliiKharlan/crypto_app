import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../repositories/crypto_coins/crypto_coins.dart';
import '../bloc/crypto_main_bloc.dart';
import '../widgets/crypto_coin_tile.dart';

class CryptoMainScreen extends StatefulWidget {
  const CryptoMainScreen({
    super.key,
  });

  @override
  State<CryptoMainScreen> createState() => _CryptoMainScreenState();
}

class _CryptoMainScreenState extends State<CryptoMainScreen> {
  final _cryptoMainBloc =
      CryptoMainBloc(GetIt.instance<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoMainBloc.add(LoadCryptoMain(completer: null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crypto Currency App'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoMainBloc.add(LoadCryptoMain(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoMainBloc, CryptoMainState>(
          bloc: _cryptoMainBloc,
          builder: (context, state) {
            if (state is CryptoMainLoaded) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsMain.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  final coin = state.coinsMain[i];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }
            if (state is CryptoMainLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please try again later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        _cryptoMainBloc.add(LoadCryptoMain(completer: null));
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
