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
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                        child: RaisedButton(
                          textColor: Colors.black,
                          color: Colors.red,
                          child: Text(
                            'Login User',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/userHomePage');
                            print(nameController.text);
                            print(passwordController.text);
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                        child: RaisedButton(
                          textColor: Colors.black,
                          color: Colors.red,
                          child: Text(
                            'Login Admin',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/adminHomePage');
                            print(nameController.text);
                            print(passwordController.text);
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                        child: RaisedButton(
                          textColor: Colors.black,
                          color: Colors.red,
                          child: Text(
                            'Login Head',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/headHomePage');
                            print(nameController.text);
                            print(passwordController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // FlatButton(
                //   onPressed: () {
                //     //forgot password screen
                //   },
                //   textColor: Colors.black,
                //   child: Text('Forgot Password'),
                // ),

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
