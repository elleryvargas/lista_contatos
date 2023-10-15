import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ContactFormScreen extends StatefulWidget {
  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _saveContact() async {
    final ParseObject contact = ParseObject('Contact')
      ..set('name', _nameController.text)
      ..set('email', _emailController.text);

    final response = await contact.save();

    if (response.success) {
      Navigator.of(context).pop();
    } else {
      // Tratar erro ao salvar o contato
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text('Salvar Contato'),
            ),
          ],
        ),
      ),
    );
  }
}
