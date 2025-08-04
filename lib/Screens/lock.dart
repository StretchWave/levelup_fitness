import 'package:flutter/material.dart';
import 'package:levelup_fitness/Screens/Home.dart';
import 'package:levelup_fitness/Styles/Stylebook.dart';
import 'package:levelup_fitness/Screens/sign.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isLoading = false;
  double screenWidth = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 16),
              Text("Logging in..."),
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Use SignupService to authenticate (uncomment when ready)
      /*
      final result = await SignupService.login(
        email: email,
        password: password,
      );
      */

      // Temporary hardcoded login for testing
      Map<String, dynamic> result;
      if (email == "test@example.com" && password == "1234") {
        result = {
          'success': true,
          'message': 'Login successful',
          'user': {'fullName': 'Test User'},
        };
      } else {
        result = {'success': false, 'message': 'Invalid email or password'};
      }

      setState(() {
        _isLoading = false;
      });

      // Hide loading and show result
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (result['success']) {
        // Login successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome back, ${result['user']['fullName']}!"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to home page (uncomment when ready)

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourBook.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Icon with subtle shadow effect
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                        255,
                        255,
                        255,
                        0.1,
                      ), // Fixed opacity
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(
                            0,
                            0,
                            0,
                            0.2,
                          ), // Fixed opacity
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.fitness_center,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Title with better typography
                  const Text(
                    "SSUP FELLAS",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to continue your fitness journey",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(
                        255,
                        255,
                        255,
                        0.8,
                      ), // Fixed opacity
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Field
                  Container(
                    height: 50,

                    //width: screenWidth * .8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(
                            0,
                            0,
                            0,
                            0.1,
                          ), // Fixed opacity
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: _improvedInputDecoration(
                        "Email",
                        Icons.email_outlined,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value != null && value.contains('@')
                          ? null
                          : 'Enter valid email',
                      onSaved: (value) => email = value ?? '',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  Container(
                    height: 50,
                    //width: screenWidth * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(
                            0,
                            0,
                            0,
                            0.1,
                          ), // Fixed opacity
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: _improvedInputDecoration(
                        "Password",
                        Icons.lock_outline,
                      ),
                      validator: (value) => value != null && value.length >= 4
                          ? null
                          : 'Min 4 characters',
                      onSaved: (value) => password = value ?? '',
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Button with gradient effect
                  Container(
                    //width: screenWidth * .85,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(
                            255,
                            255,
                            255,
                            0.3,
                          ), // Fixed opacity
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.black54,
                                ),
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Forgot Password
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Forgot password feature coming soon!"),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Color.fromRGBO(
                          255,
                          255,
                          255,
                          0.9,
                        ), // Fixed opacity
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromRGBO(
                            255,
                            255,
                            255,
                            0.3,
                          ), // Fixed opacity
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Color.fromRGBO(
                              255,
                              255,
                              255,
                              0.6,
                            ), // Fixed opacity
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromRGBO(
                            255,
                            255,
                            255,
                            0.3,
                          ), // Fixed opacity
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromRGBO(
                            255,
                            255,
                            255,
                            0.8,
                          ), // Fixed opacity
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Create New Account",
                        style: TextStyle(
                          color: Color.fromRGBO(
                            255,
                            255,
                            255,
                            0.9,
                          ), // Fixed opacity
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Updated input decoration method with fixed opacity
  InputDecoration _improvedInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.8), // Fixed opacity
        fontSize: 16,
      ),
      prefixIcon: Icon(
        icon,
        color: const Color.fromRGBO(255, 255, 255, 0.7), // Fixed opacity
        size: 22,
      ),
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.08), // Fixed opacity
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromRGBO(255, 255, 255, 0.3), // Fixed opacity
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      errorStyle: const TextStyle(fontSize: 12),
    );
  }
}
