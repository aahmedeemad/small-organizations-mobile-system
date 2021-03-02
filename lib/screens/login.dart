import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smallorgsys/providers/auth.dart';
import 'package:smallorgsys/models/http_exception.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formkey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formkey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
        emailController.text,
        passwordController.text,
      );
      if (Provider.of<Auth>(context, listen: false).user.privilege ==
          "member") {
        Navigator.of(context).pushNamed('/userHomePage');
      } else if (Provider.of<Auth>(context, listen: false).user.privilege ==
          "head") {
        Navigator.of(context).pushNamed('/headHomePage');
      } else if (Provider.of<Auth>(context, listen: false).user.privilege ==
          "admin") {
        Navigator.of(context).pushNamed('/adminHomePage');
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    // if (_formkey.currentState.validate()) {
    //   Scaffold.of(context)
    //       .showSnackBar(SnackBar(content: Text('Processing Data')));
    //   Navigator.of(context).pushNamed('/userHomePage');
    //   print(nameController.text);
    //   print(passwordController.text);
    // }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEDxMIU'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'TEDxMIU',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty || value.length < 5) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: RaisedButton(
                              textColor: Colors.black,
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: _submit,
                            ),
                          ),
                        // Container(
                        //   height: 50,
                        //   padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                        //   child: RaisedButton(
                        //     textColor: Colors.black,
                        //     color: Colors.red,
                        //     child: Text(
                        //       'Login Admin',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     onPressed: () {
                        //       if (_formkey.currentState.validate()) {
                        //         Scaffold.of(context).showSnackBar(
                        //             SnackBar(content: Text('Processing Data')));
                        //         Navigator.of(context)
                        //             .pushNamed('/adminHomePage');
                        //         print(nameController.text);
                        //         print(passwordController.text);
                        //       }
                        //     },
                        //   ),
                        // ),
                        // Container(
                        //   height: 50,
                        //   padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                        //   child: RaisedButton(
                        //     textColor: Colors.black,
                        //     color: Colors.red,
                        //     child: Text(
                        //       'Login Head',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     onPressed: () {
                        //       if (_formkey.currentState.validate()) {
                        //         Scaffold.of(context).showSnackBar(
                        //             SnackBar(content: Text('Processing Data')));
                        //         Navigator.of(context)
                        //             .pushNamed('/headHomePage');
                        //         print(nameController.text);
                        //         print(passwordController.text);
                        //       }
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
