import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const CryptoCurrencyApp());
}

class CryptoCurrencyApp extends StatelessWidget {
  const CryptoCurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Currency',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: const Color.fromARGB(248, 48, 48, 48),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        // useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(48, 48, 48, 48),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          labelSmall: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        dividerColor: Colors.white24,
        listTileTheme: const ListTileThemeData(iconColor: Colors.white),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          return ListTile(
            leading: SvgPicture.asset(
              'assets/svg/bitcoin_logo.svg',
              height: 32,
              width: 32,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: Text(
              'Bitcoin',
              style: theme.textTheme.bodyMedium,
            ),
            subtitle: Text(
              '20000\$',
              style: theme.textTheme.labelSmall,
            ),
          );
        },
      ),
    );
  }
}
