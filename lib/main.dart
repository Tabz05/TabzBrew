import 'package:brewfinfin/screens/wrapper.dart';
import 'package:brewfinfin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';

void main() async{

WidgetsFlutterBinding.ensureInitialized();
  
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
         home: Wrapper(),
      ),
    );
  }
}