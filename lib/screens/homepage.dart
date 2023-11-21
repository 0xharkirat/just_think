import 'package:flutter/material.dart';
import 'package:just_think/screens/installed_apps_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Just Think'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,



          children: [
            const Text('No apps selected'),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const InstalledAppsPage(),),
              ),
              child: const Text("Select Apps"),
            ),

          ],
        ),
      )
    );
  }
}
