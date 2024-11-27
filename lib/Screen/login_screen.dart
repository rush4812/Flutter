import 'package:electronics/Screen/home_screen.dart';
import 'package:electronics/Screen/regis_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Firebase_auth/firebase_auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text("Login"),
      // ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 120,),
              Center(
                child: Image.asset('assets/images/login.png',
                  height: 220,
                  width: 300,
                ),
              ),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Login",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Please sign in to continue.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 13,right: 13),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black,),
                    prefixIcon: const Icon(Icons.email,color: Colors.blue,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 13,right: 13),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  validator: validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black,),
                    prefixIcon: const Icon(Icons.password,color: Colors.blue,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 13,right: 13),
                child: InkWell(
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      _signIn();

                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 55,
                    width: 390,
                    child: const Center(
                      child: Text("Sign In",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.pinkAccent
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left:60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Don't have account?",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black26
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegistrationScreen(),));
                      },
                      child: const Text("Sign Up",
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _signIn() async{
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailandPassword(email, password);

    if(user!= null){
      print("User is successfully SignedIn");
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text('Login Successfulluy')));
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen(),));
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text('Please valied email and password')));
      print("Some error happed");
    }
  }
}
