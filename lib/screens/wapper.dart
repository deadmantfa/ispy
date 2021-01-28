import 'package:flutter/material.dart';
import 'package:ispy/models/local_user.dart';
import 'package:ispy/screens/authenticate/authenticate.dart';
import 'package:ispy/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<LocalUser>(context);

    // Return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
