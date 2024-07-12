import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.zachary/battery');

  Future<void> _showSwiftUIView() async {
    try {
      await platform.invokeMethod('showSwiftUIView');
    } on PlatformException catch (e) {
      print("Failed to show Location view: '${e.message}'.");
    }
  }

  Future<void> _getLocation() async {
    try {
      final location = await platform.invokeMethod<String>('getLocation');
      print('Location: $location');
    } on PlatformException catch (e) {
      print("Failed to get location: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showSwiftUIView,
              child: const Text('Show Location View'),
            ),
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
