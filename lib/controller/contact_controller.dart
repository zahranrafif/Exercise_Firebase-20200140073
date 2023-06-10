import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/view/contact.dart';

import '../model/contact_model.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();
    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.add(contact.docs);
    return contact.docs;
  }

  Future updateContact(String docId, ContactModel contactModel) async {
    final ContactModel updateContactModel = ContactModel(
      name: contactModel.name,
      phone: contactModel.phone,
      email: contactModel.email,
      address: contactModel.address,
      id: docId,
    );

    final DocumentSnapshot documentSnapshot =
        await contactCollection.doc(docId).get();
    if (!documentSnapshot.exists) {
      print('Contact With ID $docId does not exist');
      return;
    }
    final updateContact = updateContactModel.toMap();
    await contactCollection.doc(docId).update(updateContact);
    await getContact();
    print('Update contact with ID: $docId');
  }

  Future deleteContact(String docId) async {
    await contactCollection.doc(docId).delete();
    await getContact();
  }
}
