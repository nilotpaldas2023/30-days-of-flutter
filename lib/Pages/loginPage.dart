import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  final _formkey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(milliseconds: 300));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset(
                  "Assets/images/hey.png",
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome $name",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Username",
                          labelText: "Username",
                        ),
                        initialValue: '',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Username can not be empty";
                          }
                          return null;
                        },
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(20)
                        ],
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can not be empty";
                          } else if (value.length < 6) {
                            return "minimum 6 characters required";
                          }
                          return null;
                        },
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(8)
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Material(
                        color: Colors.deepPurpleAccent,
                        borderRadius:
                            BorderRadius.circular(changeButton ? 42 : 7),
                        child: InkWell(
                          onTap: () => moveToHome(context),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 350),
                            width: changeButton ? 42 : 110,
                            height: 42,
                            alignment: Alignment.center,
                            child: changeButton
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                            // decoration: BoxDecoration(
                            //     color: Colors.deepPurpleAccent,
                            // shape: changeButton
                            //     ? BoxShape.circle
                            //     : BoxShape.rectangle,
                          ),
                        ),
                      ),

                      /* ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: Text("Login"),
                        style: TextButton.styleFrom(minimumSize: Size(110, 30)),
                      ) */
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
