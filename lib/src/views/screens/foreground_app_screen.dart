import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForegroundAppScreen extends StatefulWidget {
  const ForegroundAppScreen({super.key});

  @override
  State<ForegroundAppScreen> createState() => _ForegroundAppScreenState();
}

class _ForegroundAppScreenState extends State<ForegroundAppScreen> {
  static const platform = MethodChannel('com.example.just_think/foreground');
  String _foregroundApp = "Unknown";

  Future<void> getForegroundApp() async {
    try {
      final String result = await platform.invokeMethod('getForegroundApp');
      setState(() {
        _foregroundApp = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _foregroundApp = "Failed to get foreground app: ${e.message}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getForegroundApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Foreground App')),
      body: Center(
        child: Text('Current App: $_foregroundApp'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getForegroundApp,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
