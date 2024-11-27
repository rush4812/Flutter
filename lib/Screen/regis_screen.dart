import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Firebase_auth/firebase_auth_services.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    } else if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      return 'Mobile number must be 10 digits';
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
      //   title: const Text("Registration"),
      // ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70,),
              Center(
                child: Image.asset('assets/images/electro.png',
                  height: 200,
                  width: 300,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Register",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Please register to login",
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
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  validator: validateUsername,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: const TextStyle(color: Colors.black,),
                    prefixIcon: const Icon(Icons.person,color: Colors.blue,),
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
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  validator: validateMobile,
                  decoration: InputDecoration(
                    labelText: 'Mobile no',
                    labelStyle: const TextStyle(color: Colors.black,),
                    prefixIcon: const Icon(Icons.phone,color: Colors.blue,),
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
                      // If the form is valid, display a snackbar or proceed further
                      ScaffoldMessenger.of(context)
                          .showSnackBar( SnackBar(content: Text('Register Successfulluy')));
                      _signUp();
                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen(),));
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
                      child: Text("Sign Up",
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
                    const Text("Already have account?",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black26
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen(),));
                      },
                      child: const Text("Sign In",
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

  void _signUp() async{
    String username = usernameController.text;
    String email = emailController.text;
    String number  = mobileController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailandPassword(email, password);

    if(user!= null){
      print("User is successfully created");
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen(),));
    }else{
      print("Some error happed");
    }
  }
}
