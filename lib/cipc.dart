import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// Random data generator
final random = Random();

// Function to generate random 13-digit company registration number
String generateRandomRegistrationNumber() {
  String number = '';
  for (int i = 0; i < 13; i++) {
    number += random.nextInt(10).toString();
  }
  return number;
}

// Function to generate random date
DateTime generateRandomDateJoined() {
  int randomYear =
      2015 + random.nextInt(9); // Random year between 2015 and 2024
  int randomMonth = 1 + random.nextInt(12); // Random month between 1 and 12
  int randomDay = 1 + random.nextInt(28); // Random day between 1 and 28
  return DateTime(randomYear, randomMonth, randomDay);
}

// Function to generate random password (for example purposes)
String generateRandomPassword() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(8, (index) => chars[random.nextInt(chars.length)])
      .join();
}

// Function to add random service provider data to Firestore
Future<void> addServiceProviderData() async {
  final CollectionReference serviceProviders =
      FirebaseFirestore.instance.collection('CIPC');

  // Random sample data
  List<String> companyNames = [
    'Tech Solutions',
    'Clean Sweep Services',
    'Pro Build Contractors',
    'Secure Guarding',
    'Green Landscaping',
    'Bright Future Tutoring',
    'Skyline Catering',
    'Rapid Movers',
    'Golden Plumbing',
    'Sparkle Electric'
  ];

  List<String> addresses = [
    '123 Main Street, Cityville',
    '456 Elm Avenue, Townsville',
    '789 Oak Street, Metropolis',
    '321 Pine Road, Villageton',
    '654 Maple Lane, Urbania',
  ];

  List<String> emails = [
    'info@techsolutions.com',
    'contact@cleansweep.com',
    'admin@probuild.com',
    'support@secureguarding.com',
    'hello@greenlandscaping.com',
    'info@brightfuture.com',
    'orders@skylinecatering.com',
    'bookings@rapidmovers.com',
    'service@goldenplumbing.com',
    'support@sparkleelectric.com',
  ];

  List<String> services = [
    'IT Solutions',
    'Cleaning Services',
    'Construction',
    'Security',
    'Landscaping',
    'Tutoring',
    'Catering',
    'Moving Services',
    'Plumbing',
    'Electrical'
  ];

  // Adding random entries to the Firestore collection
  for (int i = 0; i < companyNames.length; i++) {
    await serviceProviders.add({
      'companyName': companyNames[i],
      'registrationNumber': generateRandomRegistrationNumber(),
      'address': addresses[random.nextInt(addresses.length)],
      'email': emails[i],
      'service': services[i],
      'dateJoined': generateRandomDateJoined(),
      'password': generateRandomPassword(), // Random password
    });
  }

  // print("Service provider data has been added to Firestore.");
}
