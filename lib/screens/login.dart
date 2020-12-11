import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TEDxMIU Login'),
        ),
        body: Stack(
          children: <Widget>[
            Container(color: Colors.black87.withOpacity(0.8)),
            ClipPath(
              child: Container(color: Colors.redAccent[700].withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Builder(
              builder: (context) => Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'TEDxMIU',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                                validator: (value) {
                                  if (value.isEmpty) {
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
                            Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.black,
                                child: Text(
                                  'Login User',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Processing Data')));
                                    Navigator.of(context)
                                        .pushNamed('/userHomePage');
                                    print(nameController.text);
                                    print(passwordController.text);
                                  }
                                },
                              ),
                            ),
                            Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.black,
                                child: Text(
                                  'Login Admin',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Processing Data')));
                                    Navigator.of(context)
                                        .pushNamed('/adminHomePage');
                                    print(nameController.text);
                                    print(passwordController.text);
                                  }
                                },
                              ),
                            ),
                            Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.black,
                                child: Text(
                                  'Login Head',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Processing Data')));
                                    Navigator.of(context)
                                        .pushNamed('/headHomePage');
                                    print(nameController.text);
                                    print(passwordController.text);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ));
    /*return Scaffold(
        appBar: AppBar(
          title: Text('TEDxMIU'),
        ),
        body: Builder(
          builder: (context) => Padding(
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
                            validator: (value) {
                              if (value.isEmpty) {
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
                              if (_formkey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                                Navigator.of(context)
                                    .pushNamed('/userHomePage');
                                print(nameController.text);
                                print(passwordController.text);
                              }
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
                              if (_formkey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                                Navigator.of(context)
                                    .pushNamed('/adminHomePage');
                                print(nameController.text);
                                print(passwordController.text);
                              }
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
                              if (_formkey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                                Navigator.of(context)
                                    .pushNamed('/headHomePage');
                                print(nameController.text);
                                print(passwordController.text);
                              }
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
              )),
        ));*/
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
