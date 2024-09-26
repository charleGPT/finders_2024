import 'package:finders_v1_1/client_portal/screens/client_login.dart';
import 'package:flutter/material.dart';
import 'service_provider_portal/pages/service_provider_login.dart';
//import 'client_login.dart';
//import 'service_provider_login.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Portal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClientLoginPage()),
                );
              },
              child: const Text('Login as Client'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ServiceProviderLoginPage()),
                );
              },
              child: const Text('Login as Service Provider'),
            ),
          ],
        ),
      ),
    );
  }
}
