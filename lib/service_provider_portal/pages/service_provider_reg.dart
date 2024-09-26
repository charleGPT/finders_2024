import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PartnerRegistrationPage extends StatefulWidget {
  const PartnerRegistrationPage({super.key});

  @override
  _PartnerRegistrationPageState createState() =>
      _PartnerRegistrationPageState();
}

class _PartnerRegistrationPageState extends State<PartnerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers for text fields
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _registrationNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _priceController =
      TextEditingController(); // For nullable price
  TextEditingController _confirmPasswordController = TextEditingController();
  DateTime dateJoined = DateTime.timestamp();

  // Category dropdown value
  String? selectedCategory;

  // Category list
  List<String> categories = ['Household', 'Beauty', 'Electronics', 'Other'];

  // Function to handle registration
  Future<void> registerPartner() async {
    if (_formKey.currentState!.validate()) {
      // Validate passwords match
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match!')),
        );
        return;
      }

      try {
        // Register the service provider with Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Save additional service provider information to Firestore
        await _firestore
            .collection('Service Provider')
            .doc(userCredential.user!.uid)
            .set({
          'companyName': _companyNameController.text,
          'registrationNumber': _registrationNumberController.text,
          'address': _addressController.text,
          'email': _emailController.text,
          'category': selectedCategory,
          'service': _serviceController.text,
          'price': _priceController.text.isEmpty
              ? null
              : double.tryParse(_priceController.text), // Nullable price
          'dateJoined': DateTime.now(),
        });

        // Navigate to the login page after successful registration
        Navigator.pushReplacementNamed(context, '/partnerLoginPage');
      } catch (e) {
        // Handle Firebase registration error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Provider Registration'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Company Name
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Registration Number (13 digits)
              TextFormField(
                controller: _registrationNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Company Registration Number (13 digits)'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 13) {
                    return 'Please enter a valid 13-digit registration number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Address
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Service Name
              TextFormField(
                controller: _serviceController,
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the services you offer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Price (nullable)
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Service Price (optional)'),
              ),
              const SizedBox(height: 10),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: registerPartner,
                child: const Text('Register'),
              ),

              // TextButton to go to login page
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/serviceProviderLoginPage');
                },
                child: const Text('Already Registered? Login here.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
