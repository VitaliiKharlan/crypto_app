import '../features/crypto_coin/view/crypto_coin_screen.dart';
import '../features/crypto_main/view/crypto_main_screen.dart';

final routes = {
'/': (context) => const CryptoMainScreen(),
'/coin': (context) => const CryptoCoinScreen(),
};
