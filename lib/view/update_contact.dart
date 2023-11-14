import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/controller/contact_controller.dart';
import 'package:flutter_firebase/model/contact_model.dart';
import 'package:flutter_firebase/view/contact.dart';

///code kelas _UpdateContactState untuk membuat tampilan dan logika yg digunakan untuk memperbarui data kontak baru ke daftar kontak.
///akan menghasilkan code untuk mengatur tampilan dan logika untuk halaman update kontak agar pengguna dapat memperbarui
///data kontak name,phone,email,address dan menyimpannya kedalam firebase.
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
              ///code ini untuk membuat form tampilan data kontak yang akan diperbarui kedalam variabel yg sudah ditentukan.
              ///akan menampilkan form data name, phone, email, address yg kemudian data tsb akan diperbarui dan disimpan.
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

              ///code ini untuk membuat button yg berfungsi menyimpan data hasil update pengguna, dan mengarahkan kembali ke halaman kontak.
              ///akan menyimpan data kontak ke daftar kontak setelah pengguna melakukan update data. Lalu kembali ke halaman kontak.
              ElevatedButton(
                child: const Text('Update Contact'),
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    ContactModel updateContact = ContactModel(
                      id: widget.id!,
                      name: name!,
                      phone: phone!,
                      email: email!,
                      address: address!,
                    );
                    await contactController.updateContact(
                        widget.id.toString(), updateContact);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Succesfully Update')));
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
