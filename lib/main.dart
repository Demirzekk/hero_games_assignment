import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'home.dart';

// Proje hakkında detaylı bilgi 
// Direk vanilla Flutter projesi oluşturuldu. Herhangi bir state management kullanılmadı.
// Firebase için gerekli ayarlamalar yapıldı.



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HeroAssignment());
}
