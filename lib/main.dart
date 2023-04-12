import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
          getDeviceInformation();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void getDeviceInformation() async {
    String os = "", model = "", manufacturer = "", uniqueId = "";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;

    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
        os = androidInfo.version.release;
        model = androidInfo.model;
        manufacturer = androidInfo.manufacturer;
        uniqueId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
        os = iosInfo.systemVersion;
        model = iosInfo.model;
        manufacturer = iosInfo.systemName;
        uniqueId = iosInfo.identifierForVendor;
      }
    } catch (e) {
      print("Failed to get device information: $e");
    }

    // Extract device information
    // String os = Platform.isAndroid
    //     ? androidInfo.version.release
    //     : iosInfo.systemVersion;
    // String model = Platform.isAndroid ? androidInfo.model : iosInfo.model;
    // String manufacturer =
    //     Platform.isAndroid ? androidInfo.manufacturer : iosInfo.manufacturer;
    // String uniqueId = Platform.isAndroid
    //     ? androidInfo.androidId
    //     : iosInfo.identifierForVendor;

    // Print device information
    print("Operating System: $os");
    print("Model: $model");
    print("Manufacturer: $manufacturer");
    print("Unique ID: $uniqueId");
  }
}
