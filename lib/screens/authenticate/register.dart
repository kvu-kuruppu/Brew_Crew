import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggle;

  Register({required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String pwd = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggle();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInpuntDecoration.copyWith(hintText: 'Enter your email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInpuntDecoration.copyWith(hintText: 'Enter your password'),
                  obscureText: true,
                  validator: (val) => val!.length < 6
                      ? 'Enter a password with more than 6 characters'
                      : null,
                  onChanged: (val) {
                    setState(() {
                      pwd = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextButton(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.pink[400]),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await _auth.regWithEmailPwd(email, pwd);
                        if (result == null) {
                          setState(() {
                            err = 'Please enter a valid email';
                          });
                        }
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 12.0),
                Text(
                  err,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          )),
    );
  }
}
