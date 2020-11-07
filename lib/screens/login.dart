import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TEDxMIU'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'TEDxMIU Login',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                // FlatButton(
                //   onPressed: () {
                //     //forgot password screen
                //   },
                //   textColor: Colors.black,
                //   child: Text('Forgot Password'),
                // ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.black,
                    color: Colors.red,
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/userHomePage');
                      print(nameController.text);
                      print(passwordController.text);
                    },
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.black,
                    color: Colors.red,
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/adminHomePage');
                      print(nameController.text);
                      print(passwordController.text);
                    },
                  ),
                ),
                // Container(
                //   child: Row(
                //     children: <Widget>[
                //       Text('Does not have account?'),
                //       FlatButton(
                //         textColor: Colors.red,
                //         child: Text(
                //           'Signup',
                //           style: TextStyle(fontSize: 20),
                //         ),
                //         onPressed: () {
                //           //signup screen
                //         },
                //       )
                //     ],
                //     mainAxisAlignment: MainAxisAlignment.center,
                // ))
              ],
            )));
  }
}
