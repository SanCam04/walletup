import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dialog for creating a new wallet
class CreateWalletDialog extends StatefulWidget {
  const CreateWalletDialog({super.key, required this.onCreateWallet});

  final Function(String name, double initialBalance) onCreateWallet;

  @override
  State<CreateWalletDialog> createState() => _CreateWalletDialogState();
}

class _CreateWalletDialogState extends State<CreateWalletDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Wallet'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Wallet Name',
                hintText: 'Enter wallet name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Wallet name is required';
                }
                if (value.trim().length > 50) {
                  return 'Wallet name cannot exceed 50 characters';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _balanceController,
              decoration: const InputDecoration(
                labelText: 'Initial Balance',
                hintText: '0.00',
                border: OutlineInputBorder(),
                prefixText: '\$',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final balance = double.tryParse(value);
                  if (balance == null) {
                    return 'Please enter a valid amount';
                  }
                  if (balance < 0) {
                    return 'Initial balance cannot be negative';
                  }
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _createWallet, child: const Text('Create')),
      ],
    );
  }

  void _createWallet() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final balanceText = _balanceController.text.trim();
      final initialBalance = balanceText.isEmpty
          ? 0.0
          : double.parse(balanceText);

      widget.onCreateWallet(name, initialBalance);
      Navigator.of(context).pop();
    }
  }
}
