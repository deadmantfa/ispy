import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ispy/fancy/teddyController.dart';
import 'package:ispy/services/auth.dart';
import 'package:ispy/shared/constants.dart';
import 'package:ispy/shared/loading.dart';
import 'package:ispy/shared/tracking_text_input.dart';
import 'package:ispy/shared/widget.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TeddyController _teddyController;

  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text field state
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  String error = '';

  signIn() {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _auth.signInWithEmailAndPassword(
          emailTextEditingController.text, passwordTextEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: appBarMain(context),
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              width: 400,
                              child: FlareActor(
                                'assets/animations/Teddy.flr',
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                controller: _teddyController,
                                shouldClip: false,
                              ),
                            ),
                            TrackingTextInput(
                              onCaretMoved: (Offset caret) {
                                _teddyController.lookAt(caret);
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Email is required'),
                                EmailValidator(
                                    errorText: 'Please enter a vaild email.'),
                              ]),
                              controller: emailTextEditingController,
                              label: 'Email',
                              hint: 'What\'s your email address?',
                            ),
                            TrackingTextInput(
                              onCaretMoved: (Offset caret) {
                                _teddyController.coverEyes(caret != null);
                                _teddyController.lookAt(null);
                              },
                              onTextChanged: (String value) {
                                _teddyController.setPassword(value);
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Password is required'),
                                MinLengthValidator(8,
                                    errorText:
                                        'Password must be at least 8 digits long'),
                                PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                    errorText:
                                        'Passwords must have at least one special character')
                              ]),
                              controller: passwordTextEditingController,
                              label: 'Password',
                              hint: 'Its a secret...',
                              isObscured: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 0),
                          child: Text(
                            'Forgot Password?',
                            style: simpleTextPrimaryStyle,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xff0073f4),
                              const Color(0xff2a75bc),
                            ]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Sign in',
                            style: simpleTextPrimaryStyle,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          _auth.signInWithGoogle();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Sign in with Google',
                            style: simpleTextSecondaryStyle,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: simpleTextPrimaryStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Register Now",
                                style: simpleTextLinkStyle,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
