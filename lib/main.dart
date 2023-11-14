import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/view/contact.dart';
import 'package:flutter_firebase/view/login.dart';
import 'package:flutter_firebase/view/register.dart';

///code untuk menginisialisasi Firebase dan untuk dapat menjalankan aplikasi.
///akan menghasilkan penggunaan Firebase seperti firestore dan authentication dalam aplikasi.
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //intial firebase
  runApp(const MyApp());
}

///code untuk mendefinisikan kelas MyApp
///akan menghasilkan tampilan konfigurasi awal aplikasi seperti halaman utama dan apakah akan menampilkan banner debug
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      home: Contact(),
    );
  }
}
