import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/controller/contact_controller.dart';
import 'package:flutter_firebase/view/add_contact.dart';
import 'package:flutter_firebase/view/login.dart';
import 'package:flutter_firebase/view/update_contact.dart';

import '../controller/auth_controller.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var cc = ContactController();
  final autCtr = AuthController();

  @override
  void initState() {
    cc.getContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'Sign Out',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              await autCtr.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: cc.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<DocumentSnapshot> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onLongPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateContact(
                                        name: data[index]['name'].toString(),
                                        phone: data[index]['phone'].toString(),
                                        email: data[index]['email'].toString(),
                                        address:
                                            data[index]['address'].toString(),
                                        id: data[index]['id'].toString(),
                                      )));
                        },
                        child: Card(
                          elevation: 10,
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                    data[index]['name']
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              title: Text(data[index]['name']),
                              subtitle: Text(data[index]['phone']),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  cc
                                      .deleteContact(
                                          data[index]['id'].toString())
                                      .then((value) {
                                    setState(() {
                                      cc.getContact();
                                    });
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Contact Deleted Succesfully')));
                                },
                              )),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddContact(),
                ));
          },
          child: const Icon(Icons.add)),
    );
  }
}
