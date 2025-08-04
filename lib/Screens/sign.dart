import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class SignupService {
  static const String _usersKey = 'app_users';

  // Hash password for security
  static String _hashPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Generate random salt
  static String _generateSalt() {
    var random = Random.secure();
    var saltBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64.encode(saltBytes);
  }

  // Read existing users from SharedPreferences
  static Future<List<Map<String, dynamic>>> _readUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);

      if (usersJson != null) {
        final List<dynamic> jsonList = json.decode(usersJson);
        return jsonList.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Error reading users: $e');
      return [];
    }
  }

  // Write users to SharedPreferences
  static Future<void> _writeUsers(List<Map<String, dynamic>> users) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(users);
      await prefs.setString(_usersKey, jsonString);
    } catch (e) {
      print('Error writing users: $e');
      throw Exception('Failed to save user data');
    }
  }

  // Check if email already exists
  static Future<bool> _emailExists(String email) async {
    final users = await _readUsers();
    return users.any(
      (user) => user['email'].toLowerCase() == email.toLowerCase(),
    );
  }

  // Main signup function
  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    try {
      // Validate input
      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        return {
          'success': false,
          'message': 'All required fields must be filled',
        };
      }

      // Validate email format
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        return {
          'success': false,
          'message': 'Please enter a valid email address',
        };
      }

      // Validate password strength
      if (password.length < 6) {
        return {
          'success': false,
          'message': 'Password must be at least 6 characters long',
        };
      }

      // Check if email already exists
      if (await _emailExists(email)) {
        return {
          'success': false,
          'message': 'An account with this email already exists',
        };
      }

      // Generate salt and hash password
      final salt = _generateSalt();
      final hashedPassword = _hashPassword(password, salt);

      // Create user object
      final newUser = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'email': email.toLowerCase(),
        'fullName': fullName,
        'phoneNumber': phoneNumber ?? '',
        'password': hashedPassword,
        'salt': salt,
        'createdAt': DateTime.now().toIso8601String(),
        'isActive': true,
      };

      // Read existing users and add new user
      final users = await _readUsers();
      users.add(newUser);

      // Save to file
      await _writeUsers(users);

      return {
        'success': true,
        'message': 'Account created successfully!',
        'userId': newUser['id'],
      };
    } catch (e) {
      print('Signup error: $e');
      return {
        'success': false,
        'message': 'An error occurred during signup. Please try again.',
      };
    }
  }

  // Optional: Login function to verify credentials
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final users = await _readUsers();
      final user = users.firstWhere(
        (u) => u['email'].toLowerCase() == email.toLowerCase(),
        orElse: () => {},
      );

      if (user.isEmpty) {
        return {
          'success': false,
          'message': 'No account found with this email',
        };
      }

      // Verify password
      final hashedPassword = _hashPassword(password, user['salt']);
      if (hashedPassword == user['password']) {
        return {
          'success': true,
          'message': 'Login successful',
          'user': {
            'id': user['id'],
            'email': user['email'],
            'fullName': user['fullName'],
            'phoneNumber': user['phoneNumber'],
          },
        };
      } else {
        return {'success': false, 'message': 'Invalid password'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Login failed. Please try again.'};
    }
  }
}

// Enhanced signup form widget with beautiful UI
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await SignupService.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
    );

    setState(() => _isLoading = false);

    // Show enhanced snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              result['success'] ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Expanded(child: Text(result['message'])),
          ],
        ),
        backgroundColor: result['success']
            ? Colors.green.shade600
            : Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );

    if (result['success']) {
      // Navigate to login page or home page
      Navigator.pop(context);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade400, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey.shade600),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey.shade700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // Header section
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sign up to get started with your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 40),

                  // Form section
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _fullNameController,
                          label: 'Full Name',
                          icon: Icons.person_outline,
                          validator: (value) => value?.isEmpty == true
                              ? 'Full name is required'
                              : null,
                        ),

                        _buildTextField(
                          controller: _emailController,
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Email is required';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value!)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),

                        _buildTextField(
                          controller: _phoneController,
                          label: 'Phone Number (Optional)',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),

                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Password is required';
                            }
                            if (value!.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey.shade600,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: 20),

                        // Sign up button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              disabledBackgroundColor: Colors.grey.shade300,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: 24),

                        // Login link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to login page
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40),
                      ],
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
