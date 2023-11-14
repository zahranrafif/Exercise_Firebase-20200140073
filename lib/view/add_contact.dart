import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/controller/contact_controller.dart';
import 'package:flutter_firebase/model/contact_model.dart';
import 'package:flutter_firebase/view/contact.dart';

///code ini adalah kelas AddContact bagian dari pembuatan widget Flutter yang disebut AddContact.
///akan menghasilkan widget yang digunakan untuk menambahkan kontak baru ke dalam aplikasi
class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

///code kelas _AddContactState ini untuk membuat tampilan dan logika yg digunakan untuk menambahkan data kontak baru ke daftar kontak.
///akan menghasilkan code untuk mengatur tampilan dan logika untuk halaman tambah kontak
///agar pengguna dapat memasukkan data kontak baru dan menyimpannya ke firebase.
class _AddContactState extends State<AddContact> {
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
              ///code ini untuk membuat form input data kontak yang akan disimpan kedalam variabel yg sudah ditentukan.
              ///akan menampilkan form input data name, phone, email, address yg kemudian data tsb akan disimpan.
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onChanged: (value) {
                  phone = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onChanged: (value) {
                  address = value;
                },
              ),

              ///code ini untuk membuat button yg berfungsi menyimpan data hasil input pengguna, dan mengarahkan kembali ke halaman kontak
              ///akan menambahkan/menyimpan kontak baru ke daftar kontak setelah pengguna melakukan input data. Lalu kembali ke halaman kontak.
              ElevatedButton(
                child: const Text('Add Contact'),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    ContactModel cm = ContactModel(
                        name: name!,
                        phone: phone!,
                        email: email!,
                        address: address!);
                    contactController.addContact(cm);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const Contact()),
                        ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
