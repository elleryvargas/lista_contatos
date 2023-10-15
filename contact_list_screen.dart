import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<ParseObject> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final ParseResponse response = await ParseObject('Contact').getAll();
    if (response.success && response.results != null) {
      setState(() {
        contacts = response.results as List<ParseObject>;
      });
    }
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Enviar a imagem para o servidor e obter o URL
      // Atualizar o ParseObject com o URL da imagem
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final imageUrl = contact.get('profileImage');

          return ListTile(
            leading: imageUrl != null
                ? CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
                : Icon(Icons.account_circle, size: 48),
            title: Text(contact.get('name') ?? ''),
            subtitle: Text(contact.get('email') ?? ''),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactFormScreen()),
          );
        },
        tooltip: 'Adicionar Contato',
        child: Icon(Icons.add),
      ),
    );
  }
}
