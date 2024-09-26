import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finders_v1_1/client_portal/screens/all_companies.dart';
import 'package:finders_v1_1/client_portal/screens/client_home.dart';
import 'package:finders_v1_1/defaults/defaults.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final String serviceProviderId;

  const BookingPage({super.key, required this.serviceProviderId});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Map<String, int> serviceQuantities = {}; // Track quantities of each service
  double totalCost = 0.0; // Total cost for booking
  List<String> mediaUrls = []; // List to store media URLs
  String address = '';
  List<Map<String, dynamic>> services = [];

  var indexClicked = 0;

  // Fetch service provider details from Firestore
  Future<void> fetchServiceProviderDetails() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('Service Provider')
          .doc(widget.serviceProviderId)
          .get();

      if (doc.exists) {
        var data = doc.data();
        address = data?['address'] ?? 'No address available';
        services = List<Map<String, dynamic>>.from(data?['service'] ?? []);
        for (var service in services) {
          serviceQuantities[service['name']] = 0;
        }

        await fetchMedia(); // Fetch media after fetching service details
      }
    } catch (e) {
      print('Error fetching service provider details: $e');
      throw e;
    }
  }

  // Fetch media from Firebase Storage using URLs stored in Firestore
  Future<void> fetchMedia() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('Service Provider')
          .doc(widget.serviceProviderId)
          .get();

      if (doc.exists) {
        List<dynamic> mediaList = doc['mediaUrls'] ?? [];
        mediaUrls = List<String>.from(mediaList);
      }
    } catch (e) {
      print('Error fetching media: $e');
    }
  }

  // Function to calculate total booking cost
  void calculateTotalCost() {
    double total = 0.0;
    for (var service in services) {
      int quantity = serviceQuantities[service['name']] ?? 0;
      total += service['price'] * quantity;
    }
    setState(() {
      totalCost = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('FINDERS'),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pushNamed(context, '/aboutUsPage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/clientLoginPage');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: fetchServiceProviderDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address: $address',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    mediaUrls.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: mediaUrls.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                mediaUrls[index],
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : const Text('No media available'),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        var service = services[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(service['name'],
                                style: const TextStyle(fontSize: 16)),
                            Text('R${service['price']}',
                                style: const TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      if (serviceQuantities[service['name']]! >
                                          0) {
                                        serviceQuantities[service['name']] =
                                            serviceQuantities[
                                                    service['name']]! -
                                                1;
                                        calculateTotalCost();
                                      }
                                    });
                                  },
                                ),
                                Text(serviceQuantities[service['name']]
                                    .toString()),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      serviceQuantities[service['name']] =
                                          serviceQuantities[service['name']]! +
                                              1;
                                      calculateTotalCost();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R$totalCost',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Booking successfully sent!')),
                          );
                        },
                        child: const Text('Book Now'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
