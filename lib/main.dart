import 'package:flutter/material.dart';
import 'package:ispy/models/local_user.dart';
import 'package:ispy/screens/wapper.dart';
import 'package:ispy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LocalUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff145c9e),
          scaffoldBackgroundColor: Color(0xff1f1f1f),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home: Wrapper(),
      ),
    );
  }
}
