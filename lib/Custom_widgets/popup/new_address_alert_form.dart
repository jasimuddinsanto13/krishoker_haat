import 'package:flutter/material.dart';

class AddAddressDialog extends StatefulWidget {
  final Function(String address, String phone, String email) onAdd;

  const AddAddressDialog({super.key, required this.onAdd});

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Add New Address"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: 220,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value == null || value.isEmpty ? 'Enter address' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? 'Enter phone' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? 'Enter email' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text("Add"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onAdd(
                _addressController.text.trim(),
                _phoneController.text.trim(),
                _emailController.text.trim(),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
