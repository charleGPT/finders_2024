import 'package:flutter/material.dart';

class BankingDetailsForm extends StatefulWidget {
  @override
  _BankingDetailsFormState createState() => _BankingDetailsFormState();
}

class _BankingDetailsFormState extends State<BankingDetailsForm> {
  final TextEditingController _accountHolderController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  String? _selectedBank;

  final List<String> _bankNames = [
    'Capitec Pay',
    'FNB',
    'Absa',
    'Standard Bank',
    'NedBank',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bank Name Dropdown
          DropdownButtonFormField<String>(
            value: _selectedBank,
            hint: Text('Select Bank'),
            items: _bankNames.map((String bank) {
              return DropdownMenuItem<String>(
                value: bank,
                child: Text(bank),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedBank = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),

          // Account Holder Text Field
          TextField(
            controller: _accountHolderController,
            decoration: InputDecoration(
              labelText: 'Account Holder',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),

          // Account Number Text Field
          TextField(
            controller: _accountNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
