import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/controller/contact_controller.dart';
import 'package:flutter_firebase/model/contact_model.dart';
import 'package:flutter_firebase/view/contact.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact(
      {super.key, this.id, this.name, this.phone, this.email, this.address});

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var contactController = ContactController();
  final formkey = GlobalKey<FormState>();

  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
                initialValue: widget.name,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onChanged: (value) {
                  phone = value;
                },
                initialValue: widget.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
                initialValue: widget.email,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onChanged: (value) {
                  address = value;
                },
                initialValue: widget.address,
              ),
              ElevatedButton(
                  child: const Text('Update Contact'),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      ContactModel cm = ContactModel(
                          id: widget.id!,
                          name: name!,
                          phone: phone!,
                          email: email!,
                          address: address!);

                      contactController.updateContact(widget.id.toString(), cm);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Succesfully Update')));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Contact()));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
