import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/plant_provider.dart';
import 'package:account/screens/planthome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlantProvider()),
      ],
      child: MaterialApp(
        title: 'ต้นไม้สวยงามในประเทศไทย',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E88E5),
            primary: const Color(0xFF2196F3),
            secondary: const Color(0xFF42A5F5),
            surface: const Color(0xFFE3F2FD),
          ),
          scaffoldBackgroundColor: const Color(0xFFE3F2FD),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2196F3),
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PlantProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ต้นไม้สวยงามในประเทศไทย"),
        ),
        body: const TabBarView(
          children: [
            PlantHomeScreen(),
          ],
        ),
      ),
    );
  }
}
